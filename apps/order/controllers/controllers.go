package controllers

import (
	"apps/order/controllers/misc"
	"apps/order/controllers/order"

	"go.uber.org/fx"
)

// Module exported for initializing application
var Module = fx.Options(
	fx.Provide(misc_v1.NewMiscController),
	fx.Provide(order_v1.NewOrderController),
)
