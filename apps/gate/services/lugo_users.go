package services

import (
	"apps/gate/db"
	"context"

	"firebase.google.com/go/messaging"
)

type Payload struct {
	Title    string     `json:"title"`
	ImageURL string     `json:"image_url,omitempty"`
	Body     string     `json:"body,omitempty"`
	AppType  db.AppType `json:"app_type"`
}

func (u LugoService) CreatePromotion(payload Payload) error {
	if _, err := u.db.Promotion.CreateOne(
		db.Promotion.Title.Set(payload.Title),
		db.Promotion.AppType.Set(db.AppType(payload.AppType)),
		db.Promotion.ImageURL.Set(payload.ImageURL),
		db.Promotion.Description.Set(payload.Body),
	).Exec(context.Background()); err != nil {
		return err
	}
	if payload.AppType == db.AppTypeCustomer {
		if err := u.BroadCastMessage(payload, string(db.AppTypeCustomer)); err != nil {
			return err
		}
		return nil
	}
	if payload.AppType == db.AppTypeMerchant {
		if err := u.BroadCastMessage(payload, string(db.AppTypeMerchant)); err != nil {
			return err
		}
		return nil
	}
	if payload.AppType == db.AppTypeDriver {
		if err := u.BroadCastMessage(payload, string(db.AppTypeDriver)); err != nil {
			return err
		}
		return nil
	}
	return nil
}
func (u LugoService) BroadCastMessage(payload Payload, topicName string) error {
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
		Topic: topicName,
	}

	_, er := u.messaging.Send(context.Background(), msg)
	if er != nil {
		return er
	}
	return nil
}

func (u LugoService) GetPromotions(take, skip int) ([]db.PromotionModel, int, error) {
	s, err := u.db.Promotion.FindMany().With().Take(take).Skip(skip).Exec(context.Background())
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
	).With().Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return s, nil
}
