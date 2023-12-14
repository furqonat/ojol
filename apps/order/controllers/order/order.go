package order_v1

import (
	"apps/order/db"
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

func NewOrderController(logger utils.Logger, service *services.OrderService) OrderController {
	return OrderController{
		logger:  logger,
		service: service,
	}
}

func (controller OrderController) CreateOrder(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)
	orderModel := db.OrderModel{}
	if err := ctx.BindJSON(&orderModel); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal Error", "error": err.Error()})
		return
	}
	createOrder, errCreateOrder := controller.service.CreateOrder(&orderModel, customerId)
	if errCreateOrder != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request", "error": errCreateOrder.Error()})
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "Successfully create order", "res": createOrder})

}

func (controller OrderController) GetOrder(ctx *gin.Context) {
	path := ctx.Param("id")
	order, errGetOrder := controller.service.GetOrder(path)
	if errGetOrder != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errGetOrder.Error()})
		return
	}
	ctx.JSON(http.StatusOK, order)
}

func (controller OrderController) GetOrders(ctx *gin.Context) {
	queryTake := ctx.Query("take")
	querySkip := ctx.Query("skip")
	take, errTake := strconv.Atoi(queryTake)
	if errTake != nil {
		take = 10
	}
	skip, errSkip := strconv.Atoi(querySkip)
	if errSkip != nil {
		skip = 0
	}

	controller.logger.Info(take, skip, "Run it")

	orders, total, err := controller.service.GetOrders(take, skip)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"data": orders, "total": total})
}
