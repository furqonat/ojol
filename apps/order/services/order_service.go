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

type CreateOrderType struct {
	db.OrderModel
	Inner
}

type Inner struct {
	ProductId *string `json:"product_id,omitempty"`
	Quantity  *int    `json:"quantity,omitempty"`
}

func NewOrderService(database utils.Database, firestore Firestore) *OrderService {
	return &OrderService{
		database:  database,
		firestore: firestore,
	}
}

func (order OrderService) deleteOrder(orderId string) (*db.OrderModel, error) {
	return order.database.Order.FindUnique(db.Order.ID.Equals(orderId)).Delete().Exec(context.Background())
}

func (order OrderService) deleteTrx(orderId string) (*db.TransactionsModel, error) {
	return order.database.Transactions.FindUnique(db.Transactions.ID.Equals(orderId)).Delete().Exec(context.Background())
}

func (order OrderService) CreateOrder(ptrOrderModel *CreateOrderType, customerId string) (*string, *utils.CreateOrder, error) {

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
		return nil, nil, errCreateOrder
	}

	if ptrOrderModel.OrderType == db.TransactionTypeFood || ptrOrderModel.OrderType == db.TransactionTypeMart {
		if ptrOrderModel.ProductId == nil {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("product id not found")
		}

		if ptrOrderModel.Quantity != nil && *ptrOrderModel.Quantity == 0 {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("quantity must be greater than 0")
		}

		if ptrOrderModel.Quantity == nil {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("please provide quantity")
		}
		_, errCreateOrderItem := order.database.OrderItem.CreateOne(
			db.OrderItem.Product.Link(db.Product.ID.EqualsIfPresent(ptrOrderModel.ProductId)),
			db.OrderItem.Quantity.SetIfPresent(ptrOrderModel.Quantity),
			db.OrderItem.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
		).Exec(context.Background())

		if errCreateOrderItem != nil {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errCreateOrderItem
		}
	}
	trx, errCreateTrx := order.database.Transactions.CreateOne(
		db.Transactions.Type.Set(createOrderResult.OrderType),
		db.Transactions.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
	).Exec(context.Background())

	if errCreateTrx != nil {
		_, err := order.deleteOrder(createOrderResult.ID)
		if err != nil {
			return nil, nil, err
		}
		return nil, nil, errCreateTrx
	}

	errCreateTrxFirestore := order.createTrxOnFirestore(createOrderResult, trx)

	if errCreateTrxFirestore != nil {
		order.deleteTrx(trx.ID)
		order.deleteOrder(createOrderResult.ID)
		return nil, nil, errCreateTrxFirestore
	}
	if ptrOrderModel.PaymentType == db.PaymentTypeDana {
		currentTime := time.Now()

		// Add 1 hour to the current time
		oneHourLater := currentTime.Add(time.Hour)

		formattedTime := oneHourLater.Format(utils.DanaDateFormat)

		data, errDana := order.danaService.CreateNewOrder(
			formattedTime,
			"transactionType",
			fmt.Sprintf("Order:%s", ptrOrderModel.OrderType),
			createOrderResult.ID,
			ptrOrderModel.TotalAmount,
			"riskObjectId",
			"riskObjectCode",
			"riskObjectOperator",
			"",
		)
		if errDana != nil {
			order.deleteTrx(trx.ID)
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errDana
		} else {
			return &createOrderResult.ID, data, nil
		}
	} else {
		return &createOrderResult.ID, nil, nil

	}
}

func (order OrderService) CancelOrder(orderId string) (*utils.CancelOrder, error) {
	const reason = "not getting driver"
	return order.danaService.CancelOrder(orderId, reason)
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

func (order OrderService) createTrxOnFirestore(ptrOrderModel *db.OrderModel, ptrTrxModel *db.TransactionsModel) error {

	ptrEndedAt := order.assignPtrTimeIfTrue(ptrTrxModel.EndedAt())
	driverId := order.assignPtrStringIfTrue(ptrOrderModel.DriverID())

	_, errCreateTrxFirestore := order.firestore.Client.Collection("transactions").Doc(ptrOrderModel.ID).Set(context.Background(), map[string]interface{}{
		"id":           ptrTrxModel.ID,
		"driver_id":    driverId,
		"customer_id":  ptrOrderModel.CustomerID,
		"payment_type": ptrOrderModel.PaymentType,
		// "payment_at":   trxPaymentAt,
		"order_type": ptrOrderModel.OrderType,
		"status":     ptrTrxModel.Status,
		"created_at": ptrTrxModel.CreatedAt,
		"ended_at":   ptrEndedAt,
	})
	if errCreateTrxFirestore != nil {
		errorMsg := fmt.Sprintf("unable to create transaction in firestore: %s", errCreateTrxFirestore.Error())
		return errors.New(errorMsg)
	}
	return nil
}

func (order OrderService) findNearlyAndGoodDriver() {

}
