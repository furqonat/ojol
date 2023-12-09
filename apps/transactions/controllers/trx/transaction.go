package trx

import (
	"apps/transactions/db"
	"apps/transactions/services"
	"apps/transactions/utils"
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

func (trxRouter TransactionRouter) CreateTransaction(ctx *gin.Context) {
	trxModel := db.TransactionsModel{}
	if err := ctx.BindJSON(&trxModel); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "Missing field"})
		return
	}
	trxServiceCreateResult, errTrxServiceCreateResult := trxRouter.service.CreateTransaction(&trxModel)
	if errTrxServiceCreateResult != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error"})
		return
	}

	ctx.JSON(http.StatusCreated, gin.H{"data": trxServiceCreateResult})
}

func (trxRouter TransactionRouter) UpdateTransaction(ctx *gin.Context) {
	trxModel := db.TransactionsModel{}
	trxId := ctx.Param("id")
	trxRouter.logger.Info(trxId)
	if err := ctx.BindJSON(&trxModel); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	trxUpdateResult, errTrxUpdateResult := trxRouter.service.UpdateTransaction(trxId, &trxModel)
	if errTrxUpdateResult != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errTrxUpdateResult.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": trxUpdateResult.ID})
}

func (trxRouter TransactionRouter) GetTransaction(ctx *gin.Context) {
	trxId := ctx.Param("id")
	trxGetResult, errTrxGetResult := trxRouter.service.GetTransaction(trxId)
	if errTrxGetResult != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": errTrxGetResult.Error()})
		return
	}
	ctx.JSON(http.StatusOK, trxGetResult)

}

func (trxRouter TransactionRouter) GetTransactions(ctx *gin.Context) {
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

	transactions, err := trxRouter.service.GetTransactions(take, skip)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusInternalServerError, gin.H{"data": transactions})

}
