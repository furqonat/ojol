package services

import (
	"cloud.google.com/go/firestore"
	"firebase.google.com/go/auth"
	"firebase.google.com/go/messaging"
)

type FirebaseAuth struct {
	*auth.Client
}

type Firestore struct {
	*firestore.Client
}

type Messaging struct {
	*messaging.Client
}

func NewFirebaseAuth(client *auth.Client) *FirebaseAuth {
	return &FirebaseAuth{client}
}

func NewFirestore(client *firestore.Client) *Firestore {
	return &Firestore{client}
}

func NewMessaging(client *messaging.Client) *Messaging {
	return &Messaging{client}
}
