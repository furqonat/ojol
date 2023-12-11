package routes

import (
	"apps/order/controllers/order"
	"apps/order/utils"
)

// MiscRoutes struct
type OrderRoutes struct {
	logger          utils.Logger
	handler         utils.RequestHandler
	orderController order.OrderController
}

// Setup Misc routes
func (s OrderRoutes) Setup() {
	s.logger.Info("Setting up routes")
	// api := s.handler.Gin.Group("/apis/v1")
	// {
	// 	api.GET("/liveness", s.miscController.GetLiveness)
	// 	api.GET("/readiness", s.miscController.GetReadiness)
	// 	api.GET("/version", s.miscController.GetVersion)

	// }
}

// NewMiscRoutes creates new Misc controller
func NewOrderRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	orderController order.OrderController,
) OrderRoutes {
	return OrderRoutes{
		handler:         handler,
		logger:          logger,
		orderController: orderController,
	}
}
