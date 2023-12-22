package trx

import (
	"apps/transactions/services"
	"apps/transactions/utils"
	"fmt"
	"net/http"

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

func (trxRouter TransactionRouter) UpdateTransaction(ctx *gin.Context) {
	//trxModel := db.TransactionsModel{}
	//trxId := ctx.Param("id")
	//trxRouter.logger.Info(trxId)
	//if err := ctx.BindJSON(&trxModel); err != nil {
	//	ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
	//	return
	//}
	//trxUpdateResult, errTrxUpdateResult := trxRouter.service.UpdateTransaction(trxId, &trxModel)
	//if errTrxUpdateResult != nil {
	//	ctx.JSON(http.StatusInternalServerError, gin.H{"message": errTrxUpdateResult.Error()})
	//	return
	//}
	//ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": trxUpdateResult.ID})
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
