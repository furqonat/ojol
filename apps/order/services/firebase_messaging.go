package services

import "firebase.google.com/go/messaging"

type Messaging struct {
	*messaging.Client
}

func NewFirebaseMessaging(messaging *messaging.Client) *Messaging {
	return &Messaging{
		messaging,
	}
}
