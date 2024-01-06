package services

import (
	"apps/order/db"
	"context"
)

func (order OrderService) MerchantAcceptOrder(orderId string) error {
	_, errGetOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.OrderStatus.Set(db.OrderStatusFindDriver),
	).Exec(context.Background())
	if errGetOrder != nil {
		return nil
	}
	err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusFindDriver))
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) MerchantRejectOrder(orderId string) error {
	_, errGetOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.OrderStatus.Set(db.OrderStatusCanceled),
	).Exec(context.Background())
	if errGetOrder != nil {
		return nil
	}

	_, err := order.CancelOrder(orderId, "Merchant rejected or not responding")
	if err != nil {
		return err
	}
	errFrs := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusCanceled))
	if errFrs != nil {
		return errFrs
	}
	return nil
}

func (order OrderService) GetAvaliableOrderForMerchant(merchantId string, take, skip int) ([]db.OrderModel, error) {
	orders, err := order.database.Order.FindMany(
		db.Order.OrderItems.Every(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
	).With(
		db.Order.Customer.Fetch(),
		db.Order.Transactions.Fetch(),
		db.Order.OrderDetail.Fetch(),
		db.Order.OrderItems.Fetch(),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return orders, nil
}
