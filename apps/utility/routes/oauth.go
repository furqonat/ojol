package routes

import (
	"apps/utility/controllers/oauth"
	"apps/utility/middlewares"
	"apps/utility/utils"
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
		api.GET("/", s.authMiddleware.HandleAuthWithRoles(utils.MERCHANT, utils.USER, utils.DRIVER), s.controller.GenerateSignIn)
		api.POST("/", s.controller.ApplyAccessToken)
		api.GET("/profile", s.authMiddleware.HandleAuthWithRoles(utils.MERCHANT, utils.USER, utils.DRIVER), s.controller.GetDanaProfile)
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
