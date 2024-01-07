package lugo

import (
	"apps/gate/db"
	"apps/gate/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func (c Controller) CreateSetting(ctx *gin.Context) {
	model := db.SettingsModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	setting, er := c.service.CreateSetting(&model)
	if er != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + er.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": setting})
}

func (c Controller) UpdateSetting(ctx *gin.Context) {
	id := ctx.Param("id")
	model := db.SettingsModel{}

	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	s, err := c.service.UpdateSetting(id, &model)

	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": s})
}

func (c Controller) GetSetting(ctx *gin.Context) {
	id := ctx.Param("id")

	s, err := c.service.GetSetting(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, s)
}

func (c Controller) GetSettings(ctx *gin.Context) {
	qTake := ctx.Query("take")
	qSkip := ctx.Query("skip")
	take, eTake := strconv.Atoi(qTake)
	if eTake != nil {
		take = 20
	}
	skip, eSkip := strconv.Atoi(qSkip)
	if eSkip != nil {
		skip = 0
	}

	s, err := c.service.GetSettings(take, skip)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, s)
}

func (c Controller) CreateBanner(ctx *gin.Context) {
	model := db.BannerModel{}

	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	s, err := c.service.CreateBanner(&model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": s})
}

func (c Controller) UpdateBanner(ctx *gin.Context) {
	id := ctx.Param("id")
	model := services.UpdateBanner{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}

	s, err := c.service.UpdateBanner(id, &model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": s})
}

func (c Controller) GetBanner(ctx *gin.Context) {
	id := ctx.Param("id")

	s, err := c.service.GetBanner(id)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, s)
}

func (c Controller) GetBanners(ctx *gin.Context) {
	qTake := ctx.Query("take")
	qSkip := ctx.Query("skip")
	take, eTake := strconv.Atoi(qTake)
	if eTake != nil {
		take = 20
	}
	skip, eSkip := strconv.Atoi(qSkip)
	if eSkip != nil {
		skip = 0
	}

	s, err := c.service.GetBanners(take, skip)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, s)
}

func (c Controller) CreateImage(ctx *gin.Context) {
	bannerId := ctx.Param("bannerId")
	model := db.BannerImagesModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	s, err := c.service.CreateImage(bannerId, &model)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusCreated, s)
}

func (c Controller) UpdateImage(ctx *gin.Context) {
	imgId := ctx.Param("imgId")
	model := db.BannerImagesModel{}
	if err := ctx.BindJSON(&model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	if err := c.service.UpdateImage(imgId, &model); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}

func (c Controller) DeleteImage(ctx *gin.Context) {
	imgId := ctx.Param("imgId")
	if err := c.service.DeleteImage(imgId); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Unexpected error :" + err.Error()})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "OK"})
}
