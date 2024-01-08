package lugo

import (
	"apps/gate/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func (c Controller) CreatePromotion(ctx *gin.Context) {
	model := services.Payload{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	if err := c.service.CreatePromotion(model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	if err := c.service.BroadCastMessage(model, string(model.AppType)); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (c Controller) BroadCastMessage(ctx *gin.Context) {
	model := services.Payload{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	if err := c.service.BroadCastMessage(model, "promotion"); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (c Controller) GetPromotion(ctx *gin.Context) {
	pId := ctx.Param("id")
	s, err := c.service.GetPromotion(pId)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}

	ctx.JSON(http.StatusOK, s)
}

func (c Controller) GetPromotions(ctx *gin.Context) {
	qTake := ctx.Query("take")
	qSkip := ctx.Query("skip")
	take, errTake := strconv.Atoi(qTake)
	skip, errSkip := strconv.Atoi(qSkip)

	if errTake != nil {
		take = 20
	}
	if errSkip != nil {
		skip = 0
	}

	s, t, err := c.service.GetPromotions(take, skip)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"data": s, "total": t})
}
