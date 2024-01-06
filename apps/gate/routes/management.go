package routes

import (
	"apps/gate/controllers/lugo"
	"apps/gate/middlewares"
	"apps/gate/utils"
)

type ManagementRoutes struct {
	logger     utils.Logger
	handler    utils.RequestHandler
	controller lugo.Controller
	middleware middlewares.JWTMiddleware
	cors       middlewares.CorsMiddleware
}

func (s ManagementRoutes) Setup() {
	s.logger.Info("Setting up routes")
	s.handler.Gin.NoRoute(s.cors.Cors())
	api := s.handler.Gin.Group("/portal").Use(s.cors.Cors()).Use(
		s.middleware.HandleAuthWithRoles(utils.SUPERADMIN, utils.ADMIN),
	)
	{
		api.POST("/services/", s.controller.CreateService)
		api.GET("/services/all", s.controller.GetServices)

		api.PUT("/services/:id", s.controller.UpdateService)
		api.DELETE("/services/:id", s.controller.DeleteService)
		api.GET("/fee", s.controller.GetTrxFee)

		api.POST("/fee", s.controller.CreateTrxFee)
		api.PUT("/fee/:id", s.controller.UpdateTrxFee)

		api.POST("/fee/distance", s.controller.GetPriceInKm)

		api.POST("/tax", s.controller.CreateTax)
		api.PUT("/tax/:taxId", s.controller.UpdateTax)

		api.POST("/settings", s.controller.CreateSetting)
		api.PUT("/settings/:id", s.controller.UpdateSetting)
		api.GET("/settings", s.controller.GetSettings)
		api.GET("/settings/:id", s.controller.GetSetting)

		api.POST("/banner", s.controller.CreateBanner)
		api.PUT("/banner/:id", s.controller.UpdateBanner)
		api.GET("/banner", s.controller.GetBanners)
		api.GET("/banner/:id", s.controller.GetBanner)
	}
}

func NewManagementRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	controller lugo.Controller,
	middleware middlewares.JWTMiddleware,
	cors middlewares.CorsMiddleware,
) ManagementRoutes {
	return ManagementRoutes{
		handler:    handler,
		logger:     logger,
		controller: controller,
		middleware: middleware,
		cors:       cors,
	}
}
