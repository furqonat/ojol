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
	jwt                 middlewares.JWTMiddleware
	cors                middlewares.CorsMiddleware
}

func (trxRoutes TrxRoutes) Setup() {
	trxRoutes.logger.Info("Setting up routes")
	trxRoutes.handler.Gin.NoRoute(trxRoutes.cors.Cors())
	trxApi := trxRoutes.handler.Gin.Group("/trx").Use(trxRoutes.cors.Cors()).Use(trxRoutes.rateLimitMiddleware.Handle())
	{
		trxApi.GET("/", trxRoutes.jwt.HandleAuthWithRoles(utils.ADMIN, utils.SUPERADMIN), trxRoutes.controller.GetTransactions)
		trxApi.GET("/:id", trxRoutes.jwt.HandleAuthWithRoles(utils.ADMIN, utils.SUPERADMIN), trxRoutes.controller.GetTrx)
		trxApi.POST("/finish", trxRoutes.controller.FinishOrder)
		trxApi.GET("/merchant", trxRoutes.authMiddleware.HandleAuthWithRoles(utils.MERCHANT), trxRoutes.controller.GetMerchantTrx)
		trxApi.GET("/driver", trxRoutes.authMiddleware.HandleAuthWithRoles(utils.DRIVER), trxRoutes.controller.GetDriverTrx)
	}
}

func NewTransactionRoutes(
	logger utils.Logger,
	handler utils.RequestHandler,
	miscController trx.TransactionRouter,
	middleware middlewares.RateLimitMiddleware,
	authMiddleware middlewares.FirebaseMiddleware,
	jwt middlewares.JWTMiddleware,
	cors middlewares.CorsMiddleware,
) TrxRoutes {
	return TrxRoutes{
		handler:             handler,
		logger:              logger,
		controller:          miscController,
		rateLimitMiddleware: middleware,
		authMiddleware:      authMiddleware,
		cors:                cors,
	}
}
