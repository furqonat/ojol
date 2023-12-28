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
	api := s.handler.Gin.Group("/gate").Use(
		s.cors.Cors(),
		s.middleware.HandleAuthWithRoles(utils.SUPERADMIN, utils.ADMIN),
	)
	{
		api.POST("/services/", s.controller.CreateService)
		api.GET("/services/all", s.controller.GetServices)

		api.PUT("/services/:id", s.controller.UpdateService)
		api.DELETE("/services/:id", s.controller.DeleteService)
		api.GET("/fee", s.controller.GetTrxFee)
		api.POST("/fee", s.controller.CreateTrxFee)
		api.GET("/fee", s.controller.GetPriceInKm)
		api.POST("/tax", s.controller.CreateTax)
		api.PUT("/tax", s.controller.UpdateTax)
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
