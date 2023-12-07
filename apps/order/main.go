package main

import (
    "github.com/joho/godotenv"
	"go.uber.org/fx"
	"apps/order/utils"
	"apps/order/bootstrap"
)

func main() {
	godotenv.Load()
	logger := utils.GetLogger().GetFxLogger()
	fx.New(bootstrap.Module, fx.Logger(logger)).Run()
}
