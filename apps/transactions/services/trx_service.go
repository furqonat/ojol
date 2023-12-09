package services

import (
	"apps/transactions/db"
	"apps/transactions/utils"
	"context"
	"errors"
	"fmt"
	"time"
)

type TrxService struct {
	database  utils.Database
	logger    utils.Logger
	firestore *Firestore
}

func NewTrxService(database utils.Database, logger utils.Logger, firestore *Firestore) *TrxService {
	return &TrxService{
		database:  database,
		logger:    logger,
		firestore: firestore,
	}
}

func (trxService TrxService) CreateTransaction(ptrTrxModel *db.TransactionsModel) (*db.TransactionsModel, error) {
	trxCreateResult, errorTrxCreateResult := trxService.database.Transactions.CreateOne(
		db.Transactions.Type.Set(ptrTrxModel.Type),
		db.Transactions.PaymentType.Set(ptrTrxModel.PaymentType),
		db.Transactions.Order.Link(db.Order.ID.Equals(ptrTrxModel.OrderID)),
		db.Transactions.Status.Set(db.TransactionStatusCreated),
	).Exec(context.Background())

	if errorTrxCreateResult != nil {
		return nil, errorTrxCreateResult
	}
	return trxCreateResult, nil
}

func (trxService TrxService) GetTransactions(take int, skip int) ([]db.TransactionsModel, error) {
	transactions, err := trxService.database.Transactions.FindMany().With(db.Transactions.Order.Fetch()).Take(take).Skip(skip).OrderBy(db.Transactions.EndedAt.Order(db.SortOrderDesc)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return transactions, nil
}

func (trxService TrxService) GetTransaction(trxId string) (*db.TransactionsModel, error) {
	transaction, errorFindUniqueTrx := trxService.database.Transactions.FindUnique(db.Transactions.ID.Equals(trxId)).Exec(context.Background())
	if errorFindUniqueTrx != nil {
		return nil, errorFindUniqueTrx
	}
	return transaction, nil
}

func (trxService TrxService) UpdateTransaction(trxId string, ptrTrxModel *db.TransactionsModel) (*db.TransactionsModel, error) {
	acceptedAt, acceptedAtIsTrue := ptrTrxModel.AcceptedAt()
	shippingAt, shippingAtIsTrue := ptrTrxModel.ShippingAt()
	deliveredAt, deliveredAtIsTrue := ptrTrxModel.DeliveredAt()
	endedAt, endedAtIsTrue := ptrTrxModel.DeliveredAt()
	paymentAt, paymentAtIsTrue := ptrTrxModel.PaymentAt()

	ptrAccepted := trxService.assignPointerIfTrue(acceptedAtIsTrue, acceptedAt)
	ptrShippingAt := trxService.assignPointerIfTrue(shippingAtIsTrue, shippingAt)
	ptrDeliveredAt := trxService.assignPointerIfTrue(deliveredAtIsTrue, deliveredAt)
	ptrEndedAt := trxService.assignPointerIfTrue(endedAtIsTrue, endedAt)
	ptrPaymentAt := trxService.assignPointerIfTrue(paymentAtIsTrue, paymentAt)

	// TODO: refund money to customer if transaction status is canceled

	// if ptrTrxModel.Status == db.TransactionStatusCanceled {
	// implement logic refund money to customer here!
	// }

	trx, errTrxFindUnique := trxService.database.Transactions.FindUnique(
		db.Transactions.ID.Equals(trxId),
	).Update(
		db.Transactions.Status.SetIfPresent(&ptrTrxModel.Status),
		db.Transactions.AcceptedAt.SetOptional(ptrAccepted),
		db.Transactions.PaymentAt.SetOptional(ptrPaymentAt),
		db.Transactions.ShippingAt.SetOptional(ptrShippingAt),
		db.Transactions.DeliveredAt.SetOptional(ptrDeliveredAt),
		db.Transactions.EndedAt.SetOptional(ptrEndedAt),
	).Exec(context.Background())

	if paymentAtIsTrue {
		order := trx.Order()

		errorCreateFirestore := trxService.createTrxOnFirestore(order)

		if errorCreateFirestore != nil {
			return nil, errorCreateFirestore
		}
	}
	if errTrxFindUnique != nil {
		return nil, errTrxFindUnique
	}
	return trx, nil
}

func (trxService TrxService) assignPointerIfTrue(condition bool, value time.Time) *time.Time {
	if condition {
		return &value
	}
	return nil
}

func (trxService TrxService) createTrxOnFirestore(ptrOrderModel *db.OrderModel) error {
	var ptrMerchantId *string
	trx, errorTrx := ptrOrderModel.Transactions()
	if !errorTrx {
		return nil
	}
	endedAt, okEndedAt := trx.EndedAt()
	ptrEndedAt := trxService.assignPointerIfTrue(okEndedAt, endedAt)

	orderMerchantId, okOrderMerchatId := ptrOrderModel.MerchantID()
	if okOrderMerchatId {
		ptrMerchantId = &orderMerchantId
	}

	trxPaymentAt, okTrxPaymentat := trx.PaymentAt()

	if !okTrxPaymentat {
		return errors.New("when creating new transaction you must be pay it! ")
	}

	_, _, errCreateTrxFirestore := trxService.firestore.Client.Collection("transactions").Add(context.Background(), map[string]interface{}{
		"id":           trx.ID,
		"driver_id":    ptrOrderModel.DriverID,
		"customer_id":  ptrOrderModel.CustomerID,
		"merchant_id":  ptrMerchantId,
		"payment_type": trx.PaymentType,
		"payment_at":   trxPaymentAt,
		"order_type":   ptrOrderModel.OrderType,
		"status":       trx.Status,
		"created_at":   trx.CreatedAt,
		"ended_at":     ptrEndedAt,
	})
	if errCreateTrxFirestore != nil {
		errorMsg := fmt.Sprintf("unable to create transaction in firestore: %s", errCreateTrxFirestore.Error())
		return errors.New(errorMsg)
	}
	return nil
}
