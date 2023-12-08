package routes

import (
	misc "apps/transactions/controllers/misc"
	"apps/transactions/middlewares"
	"apps/transactions/utils"
)

// MiscRoutes struct
type MiscRoutes struct {
	logger              utils.Logger
	handler             utils.RequestHandler
	miscController      misc.MiscController
	rateLimitMiddleware middlewares.RateLimitMiddleware
	authMiddleware      middlewares.FirebaseMiddleware
}

// Setup Misc routes
func (s MiscRoutes) Setup() {
	s.logger.Info("Setting up routes")
	miscRouter := s.handler.Gin.Group("/misc").Use(s.rateLimitMiddleware.Handle())
	{
		miscRouter.GET("/liveness", s.authMiddleware.HandleAuthWithRoles(), s.miscController.GetLiveness)
		miscRouter.GET("/readiness", s.miscController.GetReadiness)
		miscRouter.GET("/version", s.miscController.GetVersion)
	}
}

// NewMiscRoutes creates new Misc controller
func NewMiscRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	miscController misc.MiscController,
	middleware middlewares.RateLimitMiddleware,
	authMiddleware middlewares.FirebaseMiddleware,
) MiscRoutes {
	return MiscRoutes{
		handler:             handler,
		logger:              logger,
		miscController:      miscController,
		rateLimitMiddleware: middleware,
		authMiddleware:      authMiddleware,
	}
}
