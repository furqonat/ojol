package routes

import (
	"apps/transactions/controllers/tsc"
	"apps/transactions/middlewares"
	"apps/transactions/utils"
)

type TscRoutes struct {
	logger              utils.Logger
	handler             utils.RequestHandler
	controller          tsc.TransactionRouter
	rateLimitMiddleware middlewares.RateLimitMiddleware
	authMiddleware      middlewares.FirebaseMiddleware
}

// Setup Misc routes
func (s TscRoutes) Setup() {
	s.logger.Info("Setting up routes")
	tscRouter := s.handler.Gin.Group("/tsc").Use(s.rateLimitMiddleware.Handle())
	{
		tscRouter.GET("/version", s.controller.GetVersion)
		tscRouter.POST("/", s.controller.CreateTransaction)
		tscRouter.GET("/", s.controller.GetTransactions)
		tscRouter.PUT("/:id", s.controller.UpdateTransaction)
		tscRouter.GET("/:id", s.controller.GetTransaction)
	}
}

// NewTransactionRoutes creates new Misc controller
func NewTransactionRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	miscController tsc.TransactionRouter,
	middleware middlewares.RateLimitMiddleware,
	authMiddleware middlewares.FirebaseMiddleware,
) TscRoutes {
	return TscRoutes{
		handler:             handler,
		logger:              logger,
		controller:          miscController,
		rateLimitMiddleware: middleware,
		authMiddleware:      authMiddleware,
	}
}
