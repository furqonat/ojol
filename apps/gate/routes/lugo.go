package routes

import (
	"apps/gate/controllers/lugo"
	"apps/gate/middlewares"
	"apps/gate/utils"
)

type LugoRoutes struct {
	logger     utils.Logger
	handler    utils.RequestHandler
	controller lugo.Controller
	middleware middlewares.FirebaseMiddleware
	rateLimit  middlewares.RateLimitMiddleware
}

func (s LugoRoutes) Setup() {
	s.logger.Info("Setting up routes")
	api := s.handler.Gin.Group("/gate").Use(
		s.rateLimit.Handle(),
	).Use(
		s.middleware.HandleAuthWithRoles(utils.USER, utils.DRIVER, utils.MERCHANT),
	)
	{
		api.GET("/services", s.controller.GetAvailableService)
		api.GET("/fee", s.controller.GetTrxFee)
		api.GET("/fee", s.controller.GetPriceInKm)
	}
}

func NewLugoRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	controller lugo.Controller,
	middleware middlewares.FirebaseMiddleware,
	rateLimit middlewares.RateLimitMiddleware,
) LugoRoutes {
	return LugoRoutes{
		handler:    handler,
		logger:     logger,
		controller: controller,
		middleware: middleware,
		rateLimit:  rateLimit,
	}
}
