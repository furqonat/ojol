package tsc

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
	service *services.TscService
}

func NewTransactionRouter(logger utils.Logger, service *services.TscService) TransactionRouter {
	return TransactionRouter{
		logger:  logger,
		service: service,
	}
}

func (c TransactionRouter) GetVersion(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{"message": "0.0.1"})
}
func (c TransactionRouter) CreateTransaction(ctx *gin.Context) {
	model := db.TransactionsModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "Missing field"})
		return
	}
	tsc, err := c.service.CreateTransaction(&model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error"})
		return
	}

	ctx.JSON(http.StatusCreated, gin.H{"data": tsc})
}

func (c TransactionRouter) UpdateTransaction(ctx *gin.Context) {
	model := db.TransactionsModel{}
	trxId := ctx.Param("id")
	c.logger.Info(trxId)
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	trx, err := c.service.UpdateTransaction(trxId, &model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": trx.ID})
}

func (c TransactionRouter) GetTransaction(ctx *gin.Context) {
	trxId := ctx.Param("id")
	trx, err := c.service.GetTransaction(trxId)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, trx)

}

func (c TransactionRouter) GetTransactions(ctx *gin.Context) {
	qTake := ctx.Query("take")
	qSkip := ctx.Query("skip")
	take, errT := strconv.Atoi(qTake)
	if errT != nil {
		take = 10
	}
	skip, errS := strconv.Atoi(qSkip)
	if errS != nil {
		skip = 0
	}

	transactions, err := c.service.GetTransactions(take, skip)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": err.Error()})
		return
	}

	ctx.JSON(http.StatusInternalServerError, gin.H{"data": transactions})

}
