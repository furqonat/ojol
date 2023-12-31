package middlewares

import (
	"apps/transactions/services"
	"apps/transactions/utils"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

type JWTMiddleware struct {
	service services.JWTService
	logger  utils.Logger
}

func NewJWTMiddleware(service services.JWTService, logger utils.Logger) JWTMiddleware {
	return JWTMiddleware{
		service: service,
		logger:  logger,
	}
}

func (jwt JWTMiddleware) HandleAuthWithRoles(roles ...string) gin.HandlerFunc {
	return func(gCtx *gin.Context) {
		idToken, err := jwt.getTokenFromHeaders(gCtx)
		if err != nil {
			gCtx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized"})
			gCtx.Abort()
			return
		}

		token, err := jwt.service.Decode(idToken)
		if err != nil {
			jwt.logger.Info(gin.H{"message": "Unauthorized", "error": err.Error()})
			gCtx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized", "error": err.Error()})
			gCtx.Abort()
			return
		}

		if len(roles) < 1 {
			gCtx.JSON(http.StatusInternalServerError, gin.H{"message": "Server Error"})
			gCtx.Abort()
			return
		}

		if len(roles) > 0 {
			if ok := jwt.checkRoleIsValid(roles, token); !ok {
				gCtx.JSON(http.StatusForbidden, gin.H{"message": "Invalid user roles"})
				gCtx.Abort()
				return
			}
		}
		gCtx.Set(utils.UID, token.ID)
		gCtx.Set(utils.ROLES, token.Role)
		gCtx.Next()
	}
}

func (jwt JWTMiddleware) getTokenFromHeaders(c *gin.Context) (string, error) {
	bearer := c.GetHeader("Authorization")
	if bearer == "" {
		return "", ErrNoToken
	}
	token := strings.TrimPrefix(bearer, "Bearer ")
	return token, nil
}

func (jwt JWTMiddleware) checkRoleIsValid(roles []string, token *services.Claims) bool {
	for _, val := range roles {
		for _, key := range token.Role {
			if key.Name == val {
				return true
			}
		}
	}
	return false

}
