package controllers

import (
	"apps/order/controllers/misc"
	"apps/order/controllers/order"

	"go.uber.org/fx"
)

// Module exported for initializing application
var Module = fx.Options(
	fx.Provide(misc.NewMiscController),
	fx.Provide(order.NewOrderController),
)
