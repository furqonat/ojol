package order_v1

import (
	"apps/order/services"
	"apps/order/utils"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type OrderController struct {
	logger  utils.Logger
	service *services.OrderService
}

type CancelOrder struct {
	Raseon string `json:"reason"`
}

type FindDriver struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

func NewOrderController(logger utils.Logger, service *services.OrderService) OrderController {
	return OrderController{
		logger:  logger,
		service: service,
	}
}

func (controller OrderController) CreateOrder(ctx *gin.Context) {
	orderModel := services.CreateOrderType{}
	customerId := ctx.GetString(utils.UID)
	if err := ctx.BindJSON(&orderModel); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal Error", "error": err.Error()})
		return
	}
	createOrder, dana, errCreateOrder := controller.service.CreateOrder(&orderModel, customerId)
	if errCreateOrder != nil {
		controller.logger.Info(errCreateOrder.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request", "error": errCreateOrder.Error()})
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "Successfully create order", "detail": dana, "res": createOrder})

}

func (controller OrderController) CancelOrder(ctx *gin.Context) {
	orderId := ctx.Param("id")
	cancelOrder := CancelOrder{}
	if err := ctx.BindJSON(&cancelOrder); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": err.Error()})
		ctx.Abort()
		return
	}
	result, err := controller.service.CancelOrder(orderId, cancelOrder.Raseon)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": err.Error()})
		ctx.Abort()
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "Success", "res": result})

}

func (order OrderController) FindDriver(ctx *gin.Context) {
	body := FindDriver{}
	orderId := ctx.Param("orderId")
	if err := ctx.BindJSON(&body); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request", "error": err.Error()})
		ctx.Abort()
		return
	}
	errFindDriver := order.service.FindGoodAndNearlyDriver(orderId, body.Latitude, body.Longitude)
	if errFindDriver != nil {
		order.logger.Info(errFindDriver.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "server error request", "error": errFindDriver.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (order OrderController) FindOrders(ctx *gin.Context) {
	takeQuery := ctx.Query("take")
	skipQuery := ctx.Query("skip")
	take, errConv := strconv.Atoi(takeQuery)
	if errConv != nil {
		take = 20
	}
	skip, errSkip := strconv.Atoi(skipQuery)
	if errSkip != nil {
		skip = 0
	}
	orders, total, errGetOrders := order.service.GetAvaliableOrder(take, skip)

	if errGetOrders != nil {
		order.logger.Infof("unable get order %s", errGetOrders.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": errGetOrders.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"data": orders, "total": total})
}

func (order OrderController) DriverSignOnOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")
	driverId := ctx.GetString(utils.UID)

	if err := order.service.DriverSignOnOrder(orderId, driverId); err != nil {
		order.logger.Infof(err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})

}

func (order OrderController) DriverRejectOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")
	driverId := ctx.GetString(utils.UID)
	if err := order.service.DriverRejectOrder(orderId, driverId); err != nil {
		order.logger.Info("error: %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (order OrderController) DriverAccpetOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")
	driverId := ctx.GetString(utils.UID)
	if err := order.service.DriverAcceptOrder(orderId, driverId); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (order OrderController) MerchantAcceptOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")
	if err := order.service.MerchantAcceptOrder(orderId); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (order OrderController) MerchantRejectOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")
	if err := order.service.MerchantRejectOrder(orderId); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (order OrderController) MerchantGetOrders(ctx *gin.Context) {
	merchantId := ctx.GetString(utils.UID)

	takeQuery := ctx.Query("take")
	skipQuery := ctx.Query("skip")
	take, errConv := strconv.Atoi(takeQuery)
	if errConv != nil {
		take = 20
	}
	skip, errSkip := strconv.Atoi(skipQuery)
	if errSkip != nil {
		skip = 0
	}

	orders, errGetOrder := order.service.GetOrderMerchants(merchantId, take, skip)

	if errGetOrder != nil {
		order.logger.Infof("unable get order %s", errGetOrder.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": errGetOrder.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"data": orders})
}

func (order OrderController) GetOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")
	getOrder, err := order.service.GetOrder(orderId)
	if err != nil {
		order.logger.Infof("unable get order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, getOrder)
}

func (order OrderController) FinishOrder(ctx *gin.Context) {
	orderId := ctx.Param("orderId")

	if err := order.service.FinishOrder(orderId); err != nil {
		order.logger.Infof("unable finish order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (order OrderController) MerchantGetOrderInThisDay(ctx *gin.Context) {
	merchantId := ctx.GetString(utils.UID)
	orderDb, err := order.service.MerchantGetSellStatusInDay(merchantId)
	if err != nil {
		order.logger.Infof("unable finish order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, orderDb)
}
func (order OrderController) MerchantGetOrderSellThisDay(ctx *gin.Context) {
	merchantId := ctx.GetString(utils.UID)
	cancel, done, process, err := order.service.MerchantGetSellInDay(merchantId)
	if err != nil {
		order.logger.Infof("unable finish order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal server error", "error": err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{
		"done":    done,
		"cancel":  cancel,
		"process": process,
	})
}
