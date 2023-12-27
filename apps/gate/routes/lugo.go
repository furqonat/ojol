package routes

import (
	"apps/gate/controllers/lugo"
	"apps/gate/utils"
)

// MiscRoutes struct
type LugoRoutes struct {
	logger     utils.Logger
	handler    utils.RequestHandler
	controller lugo.LugoController
}

// Setup Misc routes
func (s LugoRoutes) Setup() {
	s.logger.Info("Setting up routes")
	api := s.handler.Gin.Group("/gate/services")
	{
		api.GET("/", s.controller.GetAvaliableService)
		api.GET("/all", s.controller.GetServices)
		api.PUT("/:id", s.controller.UpdateService)
		api.POST("/", s.controller.CreateService)
		api.DELETE("/:id", s.controller.DeleteService)
	}
}

// NewMiscRoutes creates new Misc controller
func NewLugoRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	controller lugo.LugoController,
) LugoRoutes {
	return LugoRoutes{
		handler:    handler,
		logger:     logger,
		controller: controller,
	}
}
