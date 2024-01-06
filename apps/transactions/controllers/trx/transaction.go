package trx

import (
	"apps/transactions/services"
	"apps/transactions/utils"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type TransactionRouter struct {
	logger  utils.Logger
	service *services.TrxService
}

func NewTransactionRouter(logger utils.Logger, service *services.TrxService) TransactionRouter {
	return TransactionRouter{
		logger:  logger,
		service: service,
	}
}

func (trxRouter TransactionRouter) GetTransactions(ctx *gin.Context) {
	queryTake := ctx.Query("take")
	querySkip := ctx.Query("skip")
	take, errTake := strconv.Atoi(queryTake)
	skip, errSkip := strconv.Atoi(querySkip)

	if errTake != nil {
		take = 10
	}
	if errSkip != nil {
		skip = 0
	}
	trxs, total, err := trxRouter.service.GetTrxs(take, skip)
	if err != nil {
		trxRouter.logger.Info(err)
		errMsg := fmt.Sprintf("unable to update order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errMsg})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"data": trxs, "total": total})
}

func (trxRouter TransactionRouter) GetTrx(ctx *gin.Context) {
	trxId := ctx.Param("id")

	trxs, err := trxRouter.service.GetTrx(trxId)
	if err != nil {
		trxRouter.logger.Info(err)
		errMsg := fmt.Sprintf("unable to update order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errMsg})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, trxs)
}

func (trxRouter TransactionRouter) FinishOrder(ctx *gin.Context) {
	model := utils.Request[utils.FinishNotify]{}
	if err := ctx.BindJSON(&model); err != nil {
		trxRouter.logger.Info(err)
		errMsg := fmt.Sprintf("unable to bind object order %s", err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errMsg})
		ctx.Abort()
		return
	}
	if errUpdate := trxRouter.service.FinishOrder(&model); errUpdate != nil {
		trxRouter.logger.Info(errUpdate)
		errMsg := fmt.Sprintf("unable to update order %s", errUpdate.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errMsg})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}
