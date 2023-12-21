package lugo

import (
	"apps/utility/db"
	"apps/utility/services"
	"apps/utility/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type LugoController struct {
	logger  utils.Logger
	service services.LugoService
}

func NewLugoController(logger utils.Logger, service services.LugoService) LugoController {
	return LugoController{
		logger:  logger,
		service: service,
	}
}

func (lugo LugoController) GetAvaliableService(ctx *gin.Context) {
	services, err := lugo.service.GetAvaliableService()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, services)
}

func (lugo LugoController) GetServices(ctx *gin.Context) {
	services, err := lugo.service.GetServices()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, services)
}

func (lugo LugoController) UpdateService(ctx *gin.Context) {
	mdl := db.ServicesModel{}
	serviceId := ctx.Param("id")
	if err := ctx.BindJSON(&mdl); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal Server Error : " + err.Error()})
		ctx.Abort()
		return
	}
	serviceID, err := lugo.service.UpdateService(serviceId, &mdl)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, serviceID)
}

func (lugo LugoController) CreateService(ctx *gin.Context) {
	mdl := db.ServicesModel{}
	if err := ctx.BindJSON(&mdl); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal Server Error : " + err.Error()})
		ctx.Abort()
		return
	}
	serviceID, err := lugo.service.CreateNewService(&mdl)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, serviceID)
}

func (lugo LugoController) DeleteService(ctx *gin.Context) {
	serviceId := ctx.Param("id")
	services, err := lugo.service.DeleteService(serviceId)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, services)
}
