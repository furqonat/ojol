package order_v1

import (
	"apps/order/services"
	"apps/order/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type OrderController struct {
	logger  utils.Logger
	service *services.OrderService
}

type CancelOrder struct {
	Raseon string `json:"reason"`
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
