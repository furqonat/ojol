package services

import (
	"apps/order/db"
	"apps/order/utils"
	"context"
	"errors"
	"fmt"
	"time"
)

type OrderService struct {
	database  utils.Database
	firestore *Firestore
}

func NewOrderService(database utils.Database, firestore *Firestore) OrderService {
	return OrderService{
		database:  database,
		firestore: firestore,
	}
}

func (order OrderService) GetOrder(orderId string) (*db.OrderModel, error) {
	getOrderResult, errorGetOrderResult := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).With(
		db.Order.OrderItems.Fetch(),
	).Exec(context.Background())

	if errorGetOrderResult != nil {
		return nil, errorGetOrderResult
	}
	return getOrderResult, nil
}

func (order OrderService) GetOrders(take int, skip int) ([]db.OrderModel, error) {

	getOrders, errGetOrders := order.database.Order.FindMany().With(
		db.Order.Transactions.Fetch(),
		db.Order.Customer.Fetch(),
		db.Order.Driver.Fetch(),
		db.Order.OrderItems.Fetch(),
	).Take(take).Skip(skip).Exec(context.Background())
	if errGetOrders != nil {
		return nil, errGetOrders
	}
	return getOrders, nil
}

func (order OrderService) CreateOrder(ptrOrderModel *db.OrderModel) (*string, error) {

	createOrderResult, errCreateOrder := order.database.Order.CreateOne(
		db.Order.OrderType.Set(ptrOrderModel.OrderType),
		db.Order.PaymentType.Set(ptrOrderModel.PaymentType),
		db.Order.Customer.Link(db.Customer.ID.Equals(ptrOrderModel.CustomerID)),
		db.Order.GrossAmount.Set(ptrOrderModel.GrossAmount),
		db.Order.NetAmount.Set(ptrOrderModel.NetAmount),
		db.Order.TotalAmount.Set(ptrOrderModel.TotalAmount),
		db.Order.ShippingCost.Set(ptrOrderModel.ShippingCost),
	).Exec(context.Background())

	if errCreateOrder != nil {
		return nil, errCreateOrder
	}
	_, errCreateTrx := order.database.Transactions.CreateOne(
		db.Transactions.Type.Set(createOrderResult.OrderType),
		db.Transactions.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
	).Exec(context.Background())

	errCreateTrxFirestore := order.createTrxOnFirestore(createOrderResult)

	if errCreateTrxFirestore != nil {
		return nil, errCreateTrxFirestore
	}
	if errCreateTrx != nil {
		return nil, errCreateTrx
	}
	return &createOrderResult.ID, nil
}

func (order OrderService) assignPtrStringIfTrue(value string, condition bool) *string {
	if condition {
		return &value
	}
	return nil
}

func (order OrderService) assignPtrTimeIfTrue(value time.Time, condition bool) *time.Time {
	if condition {
		return &value
	}
	return nil
}

func (order OrderService) createTrxOnFirestore(ptrOrderModel *db.OrderModel) error {
	trx, errorTrx := ptrOrderModel.Transactions()
	if !errorTrx {
		return nil
	}
	ptrEndedAt := order.assignPtrTimeIfTrue(trx.EndedAt())
	driverId := order.assignPtrStringIfTrue(ptrOrderModel.DriverID())

	trxPaymentAt, okTrxPaymentat := trx.PaymentAt()

	if !okTrxPaymentat {
		return errors.New("when creating new transaction you must be pay it! ")
	}

	_, _, errCreateTrxFirestore := order.firestore.Client.Collection("transactions").Add(context.Background(), map[string]interface{}{
		"id":           trx.ID,
		"driver_id":    driverId,
		"customer_id":  ptrOrderModel.CustomerID,
		"payment_type": ptrOrderModel.PaymentType,
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
