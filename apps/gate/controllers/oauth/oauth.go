package oauth

import (
	"apps/gate/services"
	"apps/gate/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type OAuthController struct {
	logger  utils.Logger
	service services.OAuthService
}

type AccessTokenBody struct {
	AccessToken string `json:"access_token"`
}

func NewOAuthController(logger utils.Logger, service services.OAuthService) OAuthController {
	return OAuthController{
		logger:  logger,
		service: service,
	}
}

func (auth OAuthController) GenerateSignIn(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)
	url := auth.service.GenerateSignUrl(customerId)

	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "signInUrl": url})
}

func (auth OAuthController) ApplyAccessToken(ctx *gin.Context) {
	customerId := ctx.Query("customerId")
	acsTkn := AccessTokenBody{}
	if err := ctx.BindJSON(&acsTkn); err != nil {
		auth.logger.Info(err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "missing access token: " + err.Error()})
		ctx.Abort()
		return
	}
	token, errTkn := auth.service.ApplyAccessToken(acsTkn.AccessToken, customerId)

	if errTkn != nil {
		auth.logger.Info(errTkn.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal error " + errTkn.Error()})
		ctx.Abort()
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": token})

}

func (auth OAuthController) GetDanaProfile(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)

	profile, errProfile := auth.service.GetDanaProfile(customerId)
	if errProfile != nil {
		ctx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized Exception"})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, profile)
}

func (auth OAuthController) MerchantGenerateSignIn(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)
	url := auth.service.MerchantGenerateSignUrl(customerId)

	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "signInUrl": url})
}

func (auth OAuthController) MerchantApplyAccessToken(ctx *gin.Context) {
	customerId := ctx.Query("customerId")
	acsTkn := AccessTokenBody{}
	if err := ctx.BindJSON(&acsTkn); err != nil {
		auth.logger.Info(err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "missing access token: " + err.Error()})
		ctx.Abort()
		return
	}
	token, errTkn := auth.service.MerchantApplyAccessToken(acsTkn.AccessToken, customerId)

	if errTkn != nil {
		auth.logger.Info(errTkn.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal error " + errTkn.Error()})
		ctx.Abort()
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": token})

}

func (auth OAuthController) MerchantGetDanaProfile(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)

	profile, errProfile := auth.service.MerchantGetDanaProfile(customerId)
	if errProfile != nil {
		ctx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized Exception"})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, profile)
}

func (auth OAuthController) DriverGenerateSignIn(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)
	url := auth.service.DriverGenerateSignUrl(customerId)

	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "signInUrl": url})
}

func (auth OAuthController) DriverApplyAccessToken(ctx *gin.Context) {
	customerId := ctx.Query("customerId")
	acsTkn := AccessTokenBody{}
	if err := ctx.BindJSON(&acsTkn); err != nil {
		auth.logger.Info(err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{"message": "missing access token: " + err.Error()})
		ctx.Abort()
		return
	}
	token, errTkn := auth.service.DriverApplyAccessToken(acsTkn.AccessToken, customerId)

	if errTkn != nil {
		auth.logger.Info(errTkn.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"message": "Internal error " + errTkn.Error()})
		ctx.Abort()
		return
	}

	ctx.JSON(http.StatusOK, gin.H{"message": "OK", "res": token})

}

func (auth OAuthController) DriverGetDanaProfile(ctx *gin.Context) {
	customerId := ctx.GetString(utils.UID)

	profile, errProfile := auth.service.DriverGetDanaProfile(customerId)
	if errProfile != nil {
		ctx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized Exception"})
		ctx.Abort()
		return
	}
	ctx.JSON(http.StatusOK, profile)
}
