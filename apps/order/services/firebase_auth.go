package services

import "firebase.google.com/go/auth"

type FirebaseAuth struct {
	*auth.Client
}

func NewFirebaseAuth(fa *auth.Client) FirebaseAuth {
	return FirebaseAuth{fa}
}
