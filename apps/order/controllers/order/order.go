package order

import (
	"apps/order/utils"

	"github.com/gin-gonic/gin"
)

type OrderController struct {
	logger utils.Logger
}

func NewOrderController(logger utils.Logger) OrderController {
	return OrderController{
		logger: logger,
	}
}

func (controller OrderController) GetOrder(ctx *gin.Context) {

}
