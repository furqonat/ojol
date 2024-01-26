package services

import (
	"apps/transactions/db"
	"apps/transactions/utils"
	"context"
	"errors"
	"strings"
	"time"

	"cloud.google.com/go/firestore"
)

type TrxService struct {
	database  utils.Database
	logger    utils.Logger
	firestore Firestore
}

func NewTrxService(database utils.Database, logger utils.Logger, firestore Firestore) *TrxService {
	return &TrxService{
		database:  database,
		logger:    logger,
		firestore: firestore,
	}
}

const (
	OK      = "00"
	EXPIRED = "05"
)

func (trx TrxService) GetTrx(trxId string) (*db.TransactionsModel, error) {
	transaction, err := trx.database.Transactions.FindUnique(
		db.Transactions.ID.Equals(trxId),
	).With(
		db.Transactions.Order.Fetch().With(
			db.Order.Customer.Fetch(),
			db.Order.Driver.Fetch(),
			db.Order.OrderDetail.Fetch(),
			db.Order.OrderItems.Fetch().With(
				db.OrderItem.Product.Fetch().With(
					db.Product.Merchant.Fetch(),
				),
			),
		),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return transaction, nil
}

func (trx TrxService) GetTrxs(take, skip int) ([]db.TransactionsModel, int, error) {
	transaction, err := trx.database.Transactions.FindMany().With(
		db.Transactions.Order.Fetch().With(
			db.Order.Customer.Fetch(),
			db.Order.Driver.Fetch(),
			db.Order.OrderDetail.Fetch(),
			db.Order.OrderItems.Fetch().With(
				db.OrderItem.Product.Fetch().With(
					db.Product.Merchant.Fetch(),
				),
			),
		),
	).Take(take).Skip(skip).Exec(context.Background())
	total, errTotal := trx.database.TransactionDetail.FindMany().Exec(context.Background())
	if err != nil {
		return nil, 0, err
	}
	if errTotal != nil {
		return nil, 0, errTotal
	}
	return transaction, len(total), nil
}

func (trxService TrxService) FinishOrder(data *utils.FinishNotifySnap) error {
	id := data.OriginalPartnerReferenceNo
	oType := strings.Split(id, "-")
	trxService.logger.Info(oType)
	trxService.logger.Info(id)

	trxService.logger.Info(data)

	if oType[0] == "TPD" {
		return trxService.adjustDriverBalance(oType[1], data.LatestTransactionStatus)
	}
	if oType[0] == "TPM" {
		return trxService.adjustMerchantBalance(oType[1], data.LatestTransactionStatus)
	}
	order, errOrder := trxService.database.Order.FindUnique(
		db.Order.ID.Equals(oType[len(oType)-1]),
	).With(
		db.Order.Transactions.Fetch(),
	).Exec(context.Background())
	if errOrder != nil {
		return errOrder
	}
	trx, okTrx := order.Transactions()
	if !okTrx {
		return errors.New("unable fetch transactions")
	}
	dateTimeString := data.FinishedTime
	datetime, errParse := time.Parse(utils.DanaDateFormat, dateTimeString)
	if errParse != nil {
		return errParse
	}
	var isSuccess *time.Time
	var isExpired *time.Time
	status := trxService.assignTrxStatus(data.LatestTransactionStatus)
	if status == db.TransactionStatusPaid {
		isSuccess = &datetime
	}
	if status == db.TransactionStatusDone || status == db.TransactionStatusCanceled {
		isExpired = &datetime
	}

	orderStatus := trxService.assignOrderStatus(data.LatestTransactionStatus, order)

	_, errUpdateOrder := trxService.database.Order.FindUnique(
		db.Order.ID.Equals(order.ID),
	).Update(
		db.Order.OrderStatus.Set(orderStatus),
	).Exec(context.Background())

	if errUpdateOrder != nil {
		return errUpdateOrder
	}
	_, errUpdateTrx := trxService.database.Transactions.FindUnique(
		db.Transactions.ID.Equals(trx.ID),
	).Update(
		db.Transactions.PaymentAt.SetIfPresent(isSuccess),
		db.Transactions.Status.Set(status),
		db.Transactions.EndedAt.SetIfPresent(isExpired),
	).Exec(context.Background())

	if errUpdateTrx != nil {
		return errUpdateTrx
	}
	if isSuccess != nil {
		erFrs := trxService.SuccessTrxOnFirestore(isSuccess, order.ID, status)
		if erFrs != nil {
			return erFrs
		}
	}
	if isExpired != nil {
		erFrs := trxService.ExpiredTrxOnFirestore(isSuccess, order.ID, status)
		if erFrs != nil {
			return erFrs
		}
	}
	return nil
}

func (trxService TrxService) adjustMerchantBalance(trxId string, statusTrx string) error {
	status := trxService.assignTrxStatus(statusTrx)
	if status == db.TransactionStatusPaid {
		trxService.logger.Info(trxId)
		trx, err := trxService.database.MerchantTrx.FindUnique(
			db.MerchantTrx.ID.Equals(trxId),
		).Update(
			db.MerchantTrx.Status.Set(db.TrxStatusSuccess),
		).Exec(context.Background())
		if err != nil {
			return err
		}
		trxService.logger.Info(trx.MerchantID)
		_, errB := trxService.database.MerchantWallet.FindUnique(
			db.MerchantWallet.MerchantID.Equals(trx.MerchantID),
		).Update(
			db.MerchantWallet.Balance.Increment(trx.Amount),
		).Exec(context.Background())

		if errB != nil {
			return errB
		}
		if err := trxService.createTrxCompnay(db.TrxTypeAdjustment, db.TrxCompanyTypeMerchant, trx.Amount); err != nil {
			return err
		}
	}
	if status == db.TransactionStatusDone || status == db.TransactionStatusCanceled {
		// isExpired = &datetime
		return nil
	}
	return nil

}

func (trxService TrxService) adjustDriverBalance(trxId string, statusTrx string) error {
	status := trxService.assignTrxStatus(statusTrx)
	if status == db.TransactionStatusPaid {
		trx, err := trxService.database.DriverTrx.FindUnique(
			db.DriverTrx.ID.Equals(trxId),
		).Update(
			db.DriverTrx.Status.Set(db.TrxStatusSuccess),
		).Exec(context.Background())
		if err != nil {
			return err
		}
		_, errB := trxService.database.DriverWallet.FindUnique(
			db.DriverWallet.DriverID.Equals(trx.DriverID),
		).Update(
			db.DriverWallet.Balance.Increment(trx.Amount),
		).Exec(context.Background())

		if errB != nil {
			return errB
		}
		if err := trxService.createTrxCompnay(db.TrxTypeAdjustment, db.TrxCompanyTypeDriver, trx.Amount); err != nil {
			return err
		}

	}
	if status == db.TransactionStatusDone || status == db.TransactionStatusCanceled {
		// isExpired = &datetime
		return nil
	}
	return nil

}

func (trx TrxService) createTrxCompnay(trxType db.TrxType, trxFrom db.TrxCompanyType, amount int) error {
	_, err := trx.database.TrxCompany.CreateOne(
		db.TrxCompany.TrxType.Set(trxType),
		db.TrxCompany.TrxFrom.Set(trxFrom),
		db.TrxCompany.Amount.Set(amount),
	).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (trxService TrxService) SuccessTrxOnFirestore(paymentAt *time.Time, orderId string, status db.TransactionStatus) error {
	_, err := trxService.firestore.Client.Collection("transactions").Doc(orderId).Update(context.Background(), []firestore.Update{
		{
			Path:  "status",
			Value: status,
		},
		{
			Path:  "payment_at",
			Value: paymentAt,
		},
	})
	if err != nil {
		return err
	}
	return nil
}

func (trxService TrxService) ExpiredTrxOnFirestore(paymentAt *time.Time, orderId string, status db.TransactionStatus) error {
	_, err := trxService.firestore.Client.Collection("transactions").Doc(orderId).Update(context.Background(), []firestore.Update{
		{
			Path:  "status",
			Value: status,
		},
		{
			Path:  "ended_et",
			Value: paymentAt,
		},
	})
	if err != nil {
		return err
	}
	return nil
}

func (trxService TrxService) assignTrxStatus(status string) db.TransactionStatus {
	if status == EXPIRED {
		return db.TransactionStatusExpired
	}
	if status == OK {
		return db.TransactionStatusPaid
	}
	return db.TransactionStatusProcess
}

func (trxService TrxService) assignOrderStatus(status string, order *db.OrderModel) db.OrderStatus {
	if status == OK {
		return db.OrderStatusDone
	}
	if status == EXPIRED {
		if order.OrderType == db.ServiceTypeFood || order.OrderType == db.ServiceTypeMart {
			return db.OrderStatusWaitingMerchant
		}
		return db.OrderStatusFindDriver
	}
	return db.OrderStatusCreated
}

func (trxService TrxService) assignPtrTimeIfTrue(value time.Time, condition bool) *time.Time {
	if condition {
		return &value
	}
	return nil
}

func (trxService TrxService) assignPtrStringIfTrue(value string, condition bool) *string {
	if condition {
		return &value
	}
	return nil
}

func (trx TrxService) getPreviousDay() time.Time {
	currentTime := time.Now()

	currentHour := currentTime.Hour()

	adjustedTime := currentTime.Add(-time.Duration(currentHour) * time.Hour)
	return adjustedTime
}

func (trx TrxService) getNextDay() time.Time {
	currentTime := time.Now()

	currentHour := currentTime.Hour()

	adjustedTime := currentTime.Add(time.Duration(currentHour) * time.Hour)
	return adjustedTime
}

func (trx TrxService) getPreviousWeek() time.Time {
	currentTime := time.Now()
	currentDay := currentTime.Day()

	previousWeek := currentTime.AddDate(0, 0, -7-currentDay)
	return previousWeek
}

func (trx TrxService) getNextWeek() time.Time {
	currentTime := time.Now()
	currentDay := currentTime.Day()

	nextWeek := currentTime.AddDate(0, 0, 7-currentDay)
	return nextWeek
}

func (trx TrxService) getPreviousMonth() time.Time {
	currentTime := time.Now()

	previousMonth := currentTime.AddDate(0, -1, 0)
	return previousMonth
}

func (trx TrxService) getNextMonth() time.Time {
	currentTime := time.Now()

	nextMonth := currentTime.AddDate(0, 1, 0)
	return nextMonth
}
