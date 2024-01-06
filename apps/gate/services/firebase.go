package services

import (
	"cloud.google.com/go/firestore"
	"firebase.google.com/go/auth"
)

type FirebaseAuth struct {
	*auth.Client
}

type Firestore struct {
	*firestore.Client
}

func NewFirebaseAuth(client *auth.Client) *FirebaseAuth {
	return &FirebaseAuth{client}
}

func NewFirestore(client *firestore.Client) *Firestore {
	return &Firestore{client}
}
