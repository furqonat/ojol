package oauth

import (
	"apps/utility/utils"

	"github.com/gin-gonic/gin"
)

type OAuth struct {
	logger utils.Logger
}

func NewOAuthController(logger utils.Logger) OAuth {
	return OAuth{
		logger: logger,
	}
}

func (auth OAuth) GenerateSignIn(ctx *gin.Context) {

}
