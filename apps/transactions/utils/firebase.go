package utils

import (
	"context"
	"firebase.google.com/go/auth"
	"firebase.google.com/go/messaging"
	"google.golang.org/api/option"
	"path/filepath"

	firebase "firebase.google.com/go"
)

func NewFirebaseApp(logger Logger) *firebase.App {
	ctx := context.Background()

	serviceAccountKeyFilePath, err := filepath.Abs("../../google-services.json")
	if err != nil {
		logger.Panic("Unable to load serviceAccountKey.json file")
	}

	opt := option.WithCredentialsFile(serviceAccountKeyFilePath)

	app, err := firebase.NewApp(ctx, nil, opt)
	if err != nil {
		logger.Fatalf("Firebase NewApp: %v", err)
	}
	logger.Info("✅ Firebase app initialized.")
	return app
}

func NewFirebaseAuth(logger Logger, app *firebase.App) *auth.Client {
	client, err := app.Auth(context.Background())
	if err != nil {
		logger.Fatalf("unable to initialized auth client")
	}
	return client
}

func NewFirebaseMessaging(logger Logger, app *firebase.App) *messaging.Client {
	msg, err := app.Messaging(context.Background())
	if err != nil {
		logger.Fatalf("unable initialized messaging")
	}
	return msg
}
