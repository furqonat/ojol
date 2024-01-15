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
	api := s.handler.Gin.Group("/lugo").Use(
		s.rateLimit.Handle(),
	).Use(
		s.middleware.HandleAuthWithRoles(utils.MERCHANT, utils.DRIVER, utils.USER),
	)
	{
		api.GET("/services", s.controller.GetAvailableService)
		api.GET("/fee", s.controller.GetTrxFee)
		api.POST("/fee/distance", s.controller.GetPriceInKm)
		api.GET("/discount", s.controller.GetDiscounts)
		api.POST("/driver/wd", s.controller.DriverRequestWithdraw)
		api.POST("/merchant/wd", s.controller.MerchantRequestWithdraw)
		api.POST("/driver/topup", s.controller.DriverTopUp)
		api.POST("/merchant/topup", s.controller.MerchantTopUp)
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
