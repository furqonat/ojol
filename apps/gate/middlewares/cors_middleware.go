package middlewares

import (
	"apps/gate/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type CorsMiddleware struct {
	logger utils.Logger
}

func NewCorsMiddleware(logger utils.Logger) CorsMiddleware {
	return CorsMiddleware{
		logger: logger,
	}
}

func (c CorsMiddleware) Cors() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Credentials", "true")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS, GET, PUT, PATCH, DELETE")

		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusNoContent)
			return
		}
		c.Next()
	}
}
