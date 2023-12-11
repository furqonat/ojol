package services

import (
	"go.uber.org/fx"
)

// Module exports services present
var Module = fx.Options(
	fx.Provide(NewFirebaseAuth),
	fx.Provide(NewOrderService),
	fx.Provide(NewFirestoreService),
)
