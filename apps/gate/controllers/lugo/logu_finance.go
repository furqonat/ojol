package lugo

import (
	"apps/gate/db"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PriceInKM struct {
	Distance    float64        `json:"distance"`
	ServiceType db.ServiceType `json:"service_type"`
}

type CreatTax struct {
	AppliedFor db.AppliedFor `json:"applied_for"`
	TaxType    db.TaxType    `json:"tax_type"`
	Amount     int           `json:"amount"`
}

func (c Controller) GetTrxFee(ctx *gin.Context) {
	service, err := c.service.GetTrxFee()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"data": service})
}

func (c Controller) CreateTrxFee(ctx *gin.Context) {
	model := db.ServiceFeeModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	service, errService := c.service.CreateTrxFee(&model)
	if errService != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + errService.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "OK", "res": service})
}

func (c Controller) DeleteTrxFee(ctx *gin.Context) {
	feeId := ctx.Param("id")
	if err := c.service.DeleteFee(feeId); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (c Controller) UpdateTrxFee(ctx *gin.Context) {
	feeId := ctx.Param("id")
	model := db.ServiceFeeModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	fee, err := c.service.UpdateTrxFee(feeId, &model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": fee})
}

func (c Controller) GetPriceInKm(ctx *gin.Context) {
	model := PriceInKM{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	service, err := c.service.PriceInKM(model.Distance, model.ServiceType)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "price": service})
}

func (c Controller) CreateTax(ctx *gin.Context) {
	model := CreatTax{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	service, err := c.service.CreateTax(model.AppliedFor, model.TaxType, model.Amount)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "OK", "res": service})
}

func (c Controller) UpdateTax(ctx *gin.Context) {
	taxId := ctx.Param("taxId")
	model := db.TaxModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}

	service, err := c.service.UpdateTax(taxId, &model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": service})
}

func (c Controller) CreateKorlapFee(ctx *gin.Context) {
	model := db.KorlapFeeModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	s, err := c.service.CreateKorlapFee(&model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusCreated, s)
}

func (c Controller) UpdateKorlapFee(ctx *gin.Context) {
	id := ctx.Param("id")
	model := db.KorlapFeeModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	s, err := c.service.UpdateKorlapFee(id, &model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "OK", "res": s})
}

func (c Controller) DeleteKorlapFee(ctx *gin.Context) {
	id := ctx.Param("id")

	err := c.service.DeleteFee(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "OK"})
}

func (c Controller) GetKorlapFee(ctx *gin.Context) {
	qTake := ctx.Query("take")
	qSkip := ctx.Query("skip")
	take, errT := strconv.Atoi(qTake)
	if errT != nil {
		take = 20
	}
	skip, errS := strconv.Atoi(qSkip)
	if errS != nil {
		skip = 0
	}

	fees, total, err := c.service.GetKorlapFee(take, skip)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"data": fees, "total": total})
}
