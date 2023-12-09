package utils

import "go.uber.org/fx"

// Module exports dependency
var Module = fx.Options(
	fx.Provide(NewFirebaseApp),
	fx.Provide(NewFirebaseAuth),
	fx.Provide(NewFirebaseMessaging),
	fx.Provide(NewRequestHandler),
	fx.Provide(NewEnv),
	fx.Provide(GetLogger),
	fx.Provide(NewDatabase),
	fx.Provide(NewFirestoreDatabase),
)
