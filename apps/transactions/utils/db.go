package utils

import (
	"apps/transactions/db"
)

type Database struct {
	*db.PrismaClient
}

func NewDatabase(logger Logger) Database {
	client := db.NewClient()
	if err := client.Prisma.Connect(); err != nil {
		logger.Fatalf("unable connect to database")
	}

	return Database{
		client,
	}
}
