package services

import "cloud.google.com/go/firestore"

type Firestore struct {
	*firestore.Client
}

func NewFirestore(fa *firestore.Client) Firestore {
	return Firestore{fa}
}
