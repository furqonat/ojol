package main

import (
	"apps/transactions/bootstrap"
	"apps/transactions/utils"
	"os"

	"github.com/joho/godotenv"
	"go.uber.org/fx"
)

func inLambda() bool {
	if lambdaTaskRoot := os.Getenv("LAMBDA_TASK_ROOT"); lambdaTaskRoot != "" {
		return true
	} else {
		return false
	}
}

func main() {
	if inLambda() {
		// TODO: implementation gin and lambda adapter
	} else {
		godotenv.Load()
		logger := utils.GetLogger().GetFxLogger()
		fx.New(bootstrap.Module, fx.Logger(logger)).Run()
	}
}
