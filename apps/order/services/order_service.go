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
	database    utils.Database
	firestore   Firestore
	danaService DanaService
}

func NewOrderService(database utils.Database, firestore Firestore) *OrderService {
	return &OrderService{
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

func (order OrderService) GetOrders(take int, skip int) ([]db.OrderModel, int, error) {

	getOrders, errGetOrders := order.database.Order.FindMany().With(
		db.Order.OrderItems.Fetch(),
	).Take(take).Skip(skip).Exec(context.Background())
	if errGetOrders != nil {
		return nil, 0, errGetOrders
	}
	totalOrders, errGetTotalOrders := order.database.Order.FindMany().Exec(context.Background())
	if errGetTotalOrders != nil {
		return nil, 0, errGetOrders
	}
	return getOrders, len(totalOrders), nil
}

func (order OrderService) CreateOrder(ptrOrderModel *db.OrderModel, customerId string) (*string, map[string]interface{}, error) {

	createOrderResult, errCreateOrder := order.database.Order.CreateOne(
		db.Order.OrderType.Set(ptrOrderModel.OrderType),
		db.Order.PaymentType.Set(ptrOrderModel.PaymentType),
		db.Order.Customer.Link(db.Customer.ID.Equals(customerId)),
		db.Order.GrossAmount.Set(ptrOrderModel.GrossAmount),
		db.Order.NetAmount.Set(ptrOrderModel.NetAmount),
		db.Order.TotalAmount.Set(ptrOrderModel.TotalAmount),
		db.Order.ShippingCost.Set(ptrOrderModel.ShippingCost),
	).Exec(context.Background())

	if errCreateOrder != nil {
		return nil, map[string]interface{}{}, errCreateOrder
	}
	createOrderResult.OrderItems()
	_, errCreateTrx := order.database.Transactions.CreateOne(
		db.Transactions.Type.Set(createOrderResult.OrderType),
		db.Transactions.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
	).Exec(context.Background())

	errCreateTrxFirestore := order.createTrxOnFirestore(createOrderResult)

	if errCreateTrxFirestore != nil {
		return nil, map[string]interface{}{}, errCreateTrxFirestore
	}
	if errCreateTrx != nil {
		return nil, map[string]interface{}{}, errCreateTrx
	}
	currentTime := time.Now()

	// Add 1 hour to the current time
	oneHourLater := currentTime.Add(time.Hour)

	formattedTime := oneHourLater.Format("2006-01-02T15:04:05-07:00")

	data := order.danaService.CreateNewOrder(
		formattedTime,
		"transactionType",
		fmt.Sprintf("Order:%s", ptrOrderModel.OrderType),
		createOrderResult.ID,
		"",
		ptrOrderModel.TotalAmount,
		"riskObjectId",
		"riskObjectCode",
		"riskObjectOperator",
		"",
	)
	return &createOrderResult.ID, data, nil
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

	trxPaymentAt, okTrxPaymentAt := trx.PaymentAt()

	if !okTrxPaymentAt {
		return errors.New("when creating new transaction you must be pay it! ")
	}

	_, errCreateTrxFirestore := order.firestore.Client.Collection("transactions").Doc(ptrOrderModel.ID).Set(context.Background(), map[string]interface{}{
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

func (order OrderService) findNearlyAndGoodDriver() {

}
