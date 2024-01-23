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
		s.middleware.HandleAuthWithRoles(utils.SUPERADMIN, utils.ADMIN, utils.KORCAP, utils.KORLAP),
	)
	{
		api.POST("/services/", s.controller.CreateService)
		api.GET("/services/all", s.controller.GetServices)

		api.PUT("/services/:id", s.controller.UpdateService)
		api.DELETE("/services/:id", s.controller.DeleteService)
		api.GET("/fee", s.controller.GetTrxFee)

		api.POST("/fee", s.controller.CreateTrxFee)
		api.PUT("/fee/:id", s.controller.UpdateTrxFee)
		api.DELETE("/fee/:id", s.controller.DeleteTrxFee)

		api.POST("/fee/distance", s.controller.GetPriceInKm)

		api.GET("/tax", s.controller.GetTax)
		api.POST("/tax", s.controller.CreateTax)
		api.PUT("/tax/:taxId", s.controller.UpdateTax)
		api.DELETE("/tax/:taxId", s.controller.DeleteTax)

		api.POST("/settings", s.controller.CreateSetting)
		api.PUT("/settings/:id", s.controller.UpdateSetting)
		api.GET("/settings", s.controller.GetSettings)
		api.GET("/settings/:id", s.controller.GetSetting)

		api.POST("/banner", s.controller.CreateBanner)
		api.PUT("/banner/:id", s.controller.UpdateBanner)
		api.GET("/banner", s.controller.GetBanners)
		api.GET("/banner/:id", s.controller.GetBanner)

		api.POST("/img/:bannerId", s.controller.CreateImage)
		api.PUT("/img/:imgId", s.controller.UpdateImage)
		api.DELETE("/img/:imgId", s.controller.DeleteImage)

		api.POST("/promo", s.controller.CreatePromotion)
		api.POST("/promo/broadcast", s.controller.BroadCastMessage)

		api.GET("/promo", s.controller.GetPromotions)
		api.GET("/promo/:id", s.controller.GetPromotion)

		api.GET("/korlap", s.controller.GetKorlapFee)
		api.POST("/korlap", s.controller.CreateKorlapFee)
		api.PUT("/korlap/:id", s.controller.UpdateKorlapFee)
		api.DELETE("/korlap/:id", s.controller.DeleteKorlapFee)

		api.GET("/dana", s.controller.GetCompanyBallance)

		api.GET("/discount", s.controller.GetDiscounts)
		api.POST("/discount", s.controller.CreateDiscount)
		api.DELETE("/discount/:id", s.controller.DeleteDiscount)

		api.POST("/admin/wd", s.controller.AdminRequestWithdraw)

		api.GET("/trx/company", s.controller.GetTrxCompany)
		api.GET("/search", s.controller.SearchAny)
		// api.GET("/bonus", s.controller.GetBonusDrivers)
		// api.GET("/bonus/:id", s.controller.GetBonusDriver)
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
