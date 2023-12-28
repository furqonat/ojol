package lugo

import (
	"apps/gate/db"
	"github.com/gin-gonic/gin"
	"net/http"
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
