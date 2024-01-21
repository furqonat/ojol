package routes

import (
	"apps/gate/controllers/oauth"
	"apps/gate/middlewares"
	"apps/gate/utils"
)

type OAuthRoutes struct {
	logger         utils.Logger
	handler        utils.RequestHandler
	controller     oauth.OAuthController
	rateLimit      middlewares.RateLimitMiddleware
	authMiddleware middlewares.FirebaseMiddleware
}

func (s OAuthRoutes) Setup() {
	s.logger.Info("Setting up routes")
	api := s.handler.Gin.Group("/oauth").Use(s.rateLimit.Handle())
	{
		api.GET("/", s.authMiddleware.HandleAuthWithRoles(utils.USER), s.controller.GenerateSignIn)
		api.POST("/", s.controller.ApplyAccessToken)
		api.GET("/profile", s.authMiddleware.HandleAuthWithRoles(utils.USER), s.controller.GetDanaProfile)

		api.GET("/merchant", s.authMiddleware.HandleAuthWithRoles(utils.MERCHANT), s.controller.MerchantGenerateSignIn)
		api.POST("/merchant", s.controller.MerchantApplyAccessToken)
		api.GET("/merchant/profile", s.authMiddleware.HandleAuthWithRoles(utils.MERCHANT), s.controller.MerchantGetDanaProfile)

		api.GET("/driver", s.authMiddleware.HandleAuthWithRoles(utils.DRIVER), s.controller.DriverGenerateSignIn)
		api.POST("/driver", s.controller.DriverApplyAccessToken)
		api.GET("/driver/profile", s.authMiddleware.HandleAuthWithRoles(utils.DRIVER), s.controller.DriverGetDanaProfile)
	}
}

func NewOAuthRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	controller oauth.OAuthController,
	rateLimit middlewares.RateLimitMiddleware,
	authMiddleware middlewares.FirebaseMiddleware,
) OAuthRoutes {
	return OAuthRoutes{
		handler:        handler,
		logger:         logger,
		controller:     controller,
		rateLimit:      rateLimit,
		authMiddleware: authMiddleware,
	}
}
