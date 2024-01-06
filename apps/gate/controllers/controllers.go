package controllers

import (
	"apps/gate/controllers/lugo"
	"apps/gate/controllers/oauth"
	misc_v1 "apps/gate/controllers/v1/misc"

	"go.uber.org/fx"
)

// Module exported for initializing application
var Module = fx.Options(
	fx.Provide(misc_v1.NewMiscController),
	fx.Provide(oauth.NewOAuthController),
	fx.Provide(lugo.NewLugoController),
)
