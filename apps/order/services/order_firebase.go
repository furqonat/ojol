package services

import (
	"apps/order/db"
	"context"
	"errors"
	"fmt"
	"time"

	"cloud.google.com/go/firestore"
	"firebase.google.com/go/messaging"
)

func (order OrderService) sendMessageToApp(orderModel *db.OrderModel) error {
	if orderModel.OrderType == db.ServiceTypeBike || orderModel.OrderType == db.ServiceTypeCar || orderModel.OrderType == db.ServiceTypeDelivery {
		return order.sendMessageToCustomer(orderModel.CustomerID, "Silahkan bersiap sebelum driver datang menjemputmu!")
	}
	if err := order.sendMessageToCustomer(orderModel.CustomerID, "Driver sedang menuju tempat, untuk menjemput pesananmu"); err != nil {
		return err
	}
	orderItem := orderModel.OrderItems()
	if len(orderItem) < 1 {
		return errors.New("mis match order type")
	}
	merchantId := orderItem[0].Product().MerchantID
	return order.sendMessageToMerchant(merchantId, "Berhasil mendapatkan driver", "Segera siapkan pesanan, sebelum driver tiba")
}

func (order OrderService) sendMessageToMerchant(merchantId, title, message string) error {
	merchant, errGetMerchant := order.database.Merchant.FindUnique(
		db.Merchant.ID.Equals(merchantId),
	).With(
		db.Merchant.DeviceToken.Fetch(),
	).Exec(context.Background())

	if errGetMerchant != nil {
		return errGetMerchant
	}
	deviceToken, okDeviceToken := merchant.DeviceToken()

	if !okDeviceToken {
		return errors.New("unable fetch merchant device token")
	}
	err := order.firebaseSendMessage(deviceToken.Token, title, message)
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) sendMessageToCustomer(customerId string, message string) error {
	customer, errGetCustomer := order.database.Customer.FindUnique(
		db.Customer.ID.Equals(customerId),
	).With(
		db.Customer.DeviceToken.Fetch(),
	).Exec(context.Background())
	if errGetCustomer != nil {
		return errGetCustomer
	}
	token, okToken := customer.DeviceToken()
	if !okToken {
		return errors.New("unable fetch customer device token")
	}
	err := order.firebaseSendMessage(token.Token, "Berhasil mendapatkan driver", message)
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) firebaseSendMessage(token, title, msg string) error {
	message := &messaging.Message{
		Data: map[string]string{
			"title":   title,
			"message": msg,
		},
		Token: token,
	}
	_, err := order.messaging.Send(context.Background(), message)
	if err != nil {
		fmt.Printf("error send message to firebase: %s\n", err.Error())
		return nil
	}
	return nil
}

func (order OrderService) assignDriverOnFirestore(driverId, orderId string) error {
	_, err := order.firestore.Client.Collection("transactions").Doc(orderId).Update(
		context.Background(),
		[]firestore.Update{
			{
				Path:  "driver_id",
				Value: driverId,
			},
			{
				Path:  "status",
				Value: db.OrderStatusDriverOtw,
			},
		})
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) updateTrxStatusOnFirestore(orderId, status string) error {
	_, err := order.firestore.Client.Collection("transactions").Doc(orderId).Update(context.Background(), []firestore.Update{{
		Path:  "status",
		Value: status,
	}})

	if err != nil {
		return err
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
		"payment_at":   nil,
		"order_type":   ptrOrderModel.OrderType,
		"status":       ptrTrxModel.Status,
		"created_at":   ptrTrxModel.CreatedAt,
		"ended_at":     ptrEndedAt,
	})
	if errCreateTrxFirestore != nil {
		errorMsg := fmt.Sprintf("unable to create transaction in firestore: %s", errCreateTrxFirestore.Error())
		return errors.New(errorMsg)
	}
	return nil
}

func (order OrderService) CreateOrderForDriver(driverId, orderId string) error {
	_, err := order.firestore.Client.Collection("order").Doc(driverId).Set(context.Background(), map[string]interface{}{
		"orderId":    orderId,
		"driverId":   driverId,
		"created_at": time.Now(),
	})

	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) DeleteOrderForDriver(driverId, orderId string) error {
	_, err := order.firestore.Client.Collection("order").Doc(driverId).Delete(context.Background())
	if err != nil {
		return err
	}
	return nil
}
