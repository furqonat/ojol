package services

import "cloud.google.com/go/firestore"

type Firestore struct {
	*firestore.Client
}

func NewFirestoreService(fa *firestore.Client) Firestore {
	return Firestore{fa}
}
