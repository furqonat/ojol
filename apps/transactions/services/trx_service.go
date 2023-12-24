package services

import (
	"apps/transactions/db"
	"apps/transactions/utils"
	"context"
	"errors"
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

func (trxService TrxService) FinishOrder(data *utils.Request[utils.FinishNotify]) error {
	order, errOrder := trxService.database.Order.FindUnique(
		db.Order.ID.Equals(data.Request.Body.MerchantTransId),
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
	dateTimeString := data.Request.Body.FinishedTime
	datetime, errParse := time.Parse(utils.DanaDateFormat, dateTimeString)
	if errParse != nil {
		return errParse
	}
	var isSuccess *time.Time
	var isExpired *time.Time
	status := trxService.assignTrxStatus(data.Request.Body.AcquirementStatus)
	if status == db.TransactionStatusPaid {
		isSuccess = &datetime
	}
	if status == db.TransactionStatusDone || status == db.TransactionStatusCanceled {
		isExpired = &datetime
	}

	orderStatus := trxService.assignOrderStatus(data.Request.Body.AcquirementStatus)

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

func (trxService TrxService) assignTrxStatus(status utils.AcquirementStatus) db.TransactionStatus {
	if status == utils.CLOSED {
		return db.TransactionStatusExpired
	}
	if status == utils.CANCELLED {
		return db.TransactionStatusCanceled
	}
	if status == utils.SUCCESS {
		return db.TransactionStatusPaid
	}
	return db.TransactionStatusProcess
}

func (trxService TrxService) assignOrderStatus(status utils.AcquirementStatus) db.OrderStatus {
	if status == utils.CLOSED {
		return db.OrderStatusDone
	}
	if status == utils.SUCCESS {
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
