package services

import (
	"apps/order/db"
	"context"
	"fmt"
)

func (order OrderService) DriverSignOnOrder(orderId, driverId string) error {
	query := fmt.Sprintf(`
	UPDATE "order"
	SET driver_id = '%s' 
	WHERE id = '%s'
	AND driver_id IS NULL 
	`, driverId, driverId)
	_, err := order.database.Prisma.ExecuteRaw(query).Exec(context.Background())
	if err != nil {
		return err
	}
	orderDb, errGetOrderDb := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
	).Exec(context.Background())

	if errGetOrderDb != nil {
		return errGetOrderDb
	}
	if err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusDriverOtw)); err != nil {
		return err
	}
	return order.sendMessageToApp(orderDb)
}

func (order OrderService) DriverRejectOrder(orderId string, driverId string) error {
	orderExists, errOrderExists := order.database.Order.FindUnique(db.Order.ID.Equals(orderId)).Exec(context.Background())
	if errOrderExists != nil {
		return errOrderExists
	}
	_, errCreteOrderReject := order.database.OrderRejected.CreateOne(
		db.OrderRejected.Order.Link(db.Order.ID.Equals(orderExists.ID)),
		db.OrderRejected.Driver.Link(db.Driver.ID.Equals(driverId)),
	).Exec(context.Background())

	_, errUpdateOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.Driver.Unlink(),
		db.Order.Showable.Set(true),
	).Exec(context.Background())
	if errUpdateOrder != nil {
		return errUpdateOrder
	}
	if errCreteOrderReject != nil {
		return errCreteOrderReject
	}
	return nil
}

func (order OrderService) DriverAcceptOrder(orderId, driverId string) error {
	query := fmt.Sprintf(`
		UPDATE "order"
		SET driver_id = '%s' 
		WHERE id = '%s'
		AND driver_id IS NULL 
	`, driverId, driverId)
	_, errUpdateOrder := order.database.Prisma.ExecuteRaw(query).Exec(context.Background())
	if errUpdateOrder != nil {
		return errUpdateOrder
	}
	err := order.assignDriverOnFirestore(driverId, orderId)
	if err != nil {
		return err
	}
	if err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusDriverOtw)); err != nil {
		return err
	}
	return nil
}
