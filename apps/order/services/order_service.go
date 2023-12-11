package services

import (
	"apps/order/db"
	"apps/order/utils"
	"context"
)

type OrderService struct {
	database utils.Database
}

func (order OrderService) GetOrder(orderId string) (*db.OrderModel, error) {
	getOrderResult, errorGetOrderResult := order.database.Order.FindUnique(db.Order.ID.Equals(orderId)).Exec(context.Background())
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
		db.Order.Product.Fetch(),
		db.Order.Merchant.Fetch(),
	).Take(take).Skip(skip).Exec(context.Background())
	if errGetOrders != nil {
		return nil, errGetOrders
	}
	return getOrders, nil
}

func (order OrderService) CreateOrder(ptrOrderModel *db.OrderModel) (*string, error) {
	merchantId := order.assignPtrStringIfTrue(ptrOrderModel.MerchantID())
	cartId := order.assignPtrStringIfTrue(ptrOrderModel.CartID())
	driverId := order.assignPtrStringIfTrue(ptrOrderModel.DriverID())

	createOrderResult, errCreateOrder := order.database.Order.CreateOne(
		db.Order.OrderType.Set(ptrOrderModel.OrderType),
		db.Order.Customer.Link(db.Customer.ID.Equals(ptrOrderModel.CustomerID)),
		db.Order.Driver.Link(db.Driver.ID.EqualsIfPresent(driverId)),
		db.Order.Merchant.Link(db.Merchant.ID.EqualsIfPresent(merchantId)),
		db.Order.Cart.Link(db.Cart.ID.EqualsIfPresent(cartId)),
	).Exec(context.Background())

	if errCreateOrder != nil {
		return nil, errCreateOrder
	}
	return &createOrderResult.ID, nil
}

func (order OrderService) assignPtrStringIfTrue(value string, condition bool) *string {
	if condition {
		return &value
	}
	return nil
}
