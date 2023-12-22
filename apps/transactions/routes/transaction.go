package routes

import (
	"apps/transactions/controllers/trx"
	"apps/transactions/middlewares"
	"apps/transactions/utils"
)

type TrxRoutes struct {
	logger              utils.Logger
	handler             utils.RequestHandler
	controller          trx.TransactionRouter
	rateLimitMiddleware middlewares.RateLimitMiddleware
	authMiddleware      middlewares.FirebaseMiddleware
}

// Setup Misc routes
func (trxRoutes TrxRoutes) Setup() {
	trxRoutes.logger.Info("Setting up routes")
	trxApi := trxRoutes.handler.Gin.Group("/trx").Use(trxRoutes.rateLimitMiddleware.Handle())
	{
		trxApi.PUT("/:id", trxRoutes.controller.UpdateTransaction)
		trxApi.POST("/", trxRoutes.controller.FinishOrder)
	}
}

// NewTransactionRoutes creates new Transaction controller
func NewTransactionRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	miscController trx.TransactionRouter,
	middleware middlewares.RateLimitMiddleware,
	authMiddleware middlewares.FirebaseMiddleware,
) TrxRoutes {
	return TrxRoutes{
		handler:             handler,
		logger:              logger,
		controller:          miscController,
		rateLimitMiddleware: middleware,
		authMiddleware:      authMiddleware,
	}
}
