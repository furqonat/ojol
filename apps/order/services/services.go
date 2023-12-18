package services

import (
	"go.uber.org/fx"
)

// Module exports services present
var Module = fx.Options(
	fx.Provide(NewFirebaseAuth),
	fx.Provide(NewFirestoreService),
	fx.Provide(NewOrderService),
	fx.Provide(NewDanaService),
)
