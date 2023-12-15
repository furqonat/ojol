package routes

import (
	misc "apps/order/controllers/misc"
	"apps/order/middlewares"
	"apps/order/utils"
)

// MiscRoutes struct
type MiscRoutes struct {
	logger              utils.Logger
	handler             utils.RequestHandler
	miscController      misc.MiscController
	rateLimitMiddleware middlewares.RateLimitMiddleware
}

// Setup Misc routes
func (s MiscRoutes) Setup() {
	s.logger.Info("Setting up routes")
	api := s.handler.Gin.Group("/apis/v1").Use(s.rateLimitMiddleware.Handle())
	{
		api.GET("/liveness", s.miscController.GetLiveness)
		api.GET("/readiness", s.miscController.GetReadiness)
		api.GET("/version", s.miscController.GetVersion)

	}
}

// NewMiscRoutes creates new Misc controller
func NewMiscRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	miscController misc.MiscController,
	rateLimitMiddleware middlewares.RateLimitMiddleware,
) MiscRoutes {
	return MiscRoutes{
		handler:             handler,
		logger:              logger,
		miscController:      miscController,
		rateLimitMiddleware: rateLimitMiddleware,
	}
}
