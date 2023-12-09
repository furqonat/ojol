package controllers

import (
	misc "apps/transactions/controllers/misc"
	trx "apps/transactions/controllers/trx"

	"go.uber.org/fx"
)

// Module exported for initializing application
var Module = fx.Options(
	fx.Provide(misc.NewMiscController),
	fx.Provide(trx.NewTransactionRouter),
)
