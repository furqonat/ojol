package lugo

import (
	"apps/gate/db"
	"apps/gate/services"
	"apps/gate/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	logger  utils.Logger
	service services.LugoService
}

func NewLugoController(logger utils.Logger, service services.LugoService) Controller {
	return Controller{
		logger:  logger,
		service: service,
	}
}

func (c Controller) GetAvailableService(ctx *gin.Context) {
	availableService, err := c.service.GetAvailableService()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, availableService)
}

func (c Controller) GetServices(ctx *gin.Context) {
	getServices, err := c.service.GetServices()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, getServices)
}

func (c Controller) UpdateService(ctx *gin.Context) {
	mdl := db.ServicesModel{}
	serviceId := ctx.Param("id")
	if err := ctx.BindJSON(&mdl); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal Server Error : " + err.Error()})
		ctx.Abort()
		return
	}
	serviceID, err := c.service.UpdateService(serviceId, &mdl)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, serviceID)
}

func (c Controller) CreateService(ctx *gin.Context) {
	mdl := db.ServicesModel{}
	if err := ctx.BindJSON(&mdl); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal Server Error : " + err.Error()})
		ctx.Abort()
		return
	}
	serviceID, err := c.service.CreateNewService(&mdl)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, serviceID)
}

func (c Controller) DeleteService(ctx *gin.Context) {
	serviceId := ctx.Param("id")
	service, err := c.service.DeleteService(serviceId)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "internal server error " + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, service)
}
