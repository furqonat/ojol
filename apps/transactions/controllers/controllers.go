package controllers

import (
	misc "apps/transactions/controllers/misc"
	"apps/transactions/controllers/tsc"
	"go.uber.org/fx"
)

// Module exported for initializing application
var Module = fx.Options(
	fx.Provide(misc.NewMiscController),
	fx.Provide(tsc.NewTransactionRouter),
)
