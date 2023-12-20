package services

import (
	"go.uber.org/fx"
)

// Module exports services present
var Module = fx.Options(
	fx.Provide(NewOauthService),
	fx.Provide(NewDanaService),
	fx.Provide(NewFirebaseAuth),
	fx.Provide(NewFirestore),
)
