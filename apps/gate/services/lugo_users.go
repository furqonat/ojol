package services

import (
	"apps/gate/db"
	"context"
	"errors"

	"firebase.google.com/go/messaging"
)

type Payload struct {
	Title    string `json:"title"`
	ImageURL string `json:"image_url,omitempty"`
	Body     string `json:"body,omitempty"`
}

func (u LugoService) SendMessageToMerchant(merchantId string, payload Payload) error {
	merchant, err := u.db.Merchant.FindUnique(
		db.Merchant.ID.Equals(merchantId),
	).With(
		db.Merchant.DeviceToken.Fetch(),
	).Exec(context.Background())

	if err != nil {
		return err
	}
	token, ok := merchant.DeviceToken()
	if !ok {
		return errors.New("unable fetch device token")
	}
	if _, err := u.db.Promotion.CreateOne(
		db.Promotion.Title.Set(payload.Title),
		db.Promotion.ImageURL.Set(payload.ImageURL),
		db.Promotion.Description.Set(payload.Body),
		db.Promotion.Merchant.Link(db.Merchant.ID.Equals(merchantId)),
	).Exec(context.Background()); err != nil {
		return err
	}
	if err := u.sendMessage(token.Token, payload); err != nil {
		return err
	}
	return nil
}

func (u LugoService) SendMessageToDriver(driverId string, payload Payload) error {
	driver, err := u.db.Driver.FindUnique(
		db.Driver.ID.Equals(driverId),
	).With(
		db.Driver.DeviceToken.Fetch(),
	).Exec(context.Background())

	if err != nil {
		return err
	}
	token, ok := driver.DeviceToken()
	if !ok {
		return errors.New("unable fetch device token")
	}

	if _, err := u.db.Promotion.CreateOne(
		db.Promotion.Title.Set(payload.Title),
		db.Promotion.ImageURL.Set(payload.ImageURL),
		db.Promotion.Description.Set(payload.Body),
		db.Promotion.Driver.Link(db.Driver.ID.Equals(driverId)),
	).Exec(context.Background()); err != nil {
		return err
	}

	if err := u.sendMessage(token.Token, payload); err != nil {
		return err
	}
	return nil
}

func (u LugoService) SendMessageToCustomer(customerId string, payload Payload) error {
	customer, err := u.db.Customer.FindUnique(
		db.Customer.ID.Equals(customerId),
	).With(
		db.Customer.DeviceToken.Fetch(),
	).Exec(context.Background())

	if err != nil {
		return err
	}
	token, ok := customer.DeviceToken()
	if !ok {
		return errors.New("unable fetch device token")
	}
	if _, err := u.db.Promotion.CreateOne(
		db.Promotion.Title.Set(payload.Title),
		db.Promotion.ImageURL.Set(payload.ImageURL),
		db.Promotion.Description.Set(payload.Body),
		db.Promotion.Customer.Link(db.Customer.ID.Equals(customerId)),
	).Exec(context.Background()); err != nil {
		return err
	}
	if err := u.sendMessage(token.Token, payload); err != nil {
		return err
	}
	return nil
}

func (u LugoService) sendMessage(token string, payload Payload) error {
	msg := &messaging.Message{
		Notification: &messaging.Notification{
			Title: payload.Title,
		},
		Android: &messaging.AndroidConfig{
			Notification: &messaging.AndroidNotification{
				ImageURL: payload.ImageURL,
			},
		},
		APNS: &messaging.APNSConfig{
			Payload: &messaging.APNSPayload{
				Aps: &messaging.Aps{
					MutableContent: false,
				},
			},
			FCMOptions: &messaging.APNSFCMOptions{
				ImageURL: payload.ImageURL,
			},
		},
		Data: map[string]string{
			"body": payload.Body,
		},
		Token: token,
	}

	_, er := u.messaging.Send(context.Background(), msg)
	if er != nil {
		return er
	}
	return nil
}

func (u LugoService) BroadCastMessage(payload Payload) error {
	msg := &messaging.Message{
		Notification: &messaging.Notification{
			Title: payload.Title,
		},
		Android: &messaging.AndroidConfig{
			Notification: &messaging.AndroidNotification{
				ImageURL: payload.ImageURL,
			},
		},
		APNS: &messaging.APNSConfig{
			Payload: &messaging.APNSPayload{
				Aps: &messaging.Aps{
					MutableContent: false,
				},
			},
			FCMOptions: &messaging.APNSFCMOptions{
				ImageURL: payload.ImageURL,
			},
		},
		Data: map[string]string{
			"body": payload.Body,
		},
		Topic: "promotion",
	}

	_, er := u.messaging.Send(context.Background(), msg)
	if er != nil {
		return er
	}
	return nil
}

func (u LugoService) GetPromotions(take, skip int) ([]db.PromotionModel, int, error) {
	s, err := u.db.Promotion.FindMany().With(
		db.Promotion.Customer.Fetch(),
		db.Promotion.Driver.Fetch(),
		db.Promotion.Merchant.Fetch(),
	).Take(take).Skip(skip).Exec(context.Background())
	t, er := u.db.Promotion.FindMany().Exec(context.Background())
	if err != nil {
		return nil, 0, err
	}
	if er != nil {
		return nil, 0, er
	}
	return s, len(t), nil
}

func (u LugoService) GetPromotion(pId string) (*db.PromotionModel, error) {
	s, err := u.db.Promotion.FindUnique(
		db.Promotion.ID.Equals(pId),
	).With(
		db.Promotion.Customer.Fetch(),
		db.Promotion.Driver.Fetch(),
		db.Promotion.Merchant.Fetch(),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return s, nil
}
