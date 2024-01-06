package middlewares

import (
	"apps/order/services"
	"apps/order/utils"
	"context"
	"errors"
	"net/http"
	"strings"

	"firebase.google.com/go/auth"

	"github.com/gin-gonic/gin"
)

var (
	ErrNoToken = errors.New("no token provided")
)

type FirebaseMiddleware struct {
	client services.FirebaseAuth
	logger utils.Logger
}

func NewFirebaseMiddleware(frsAuth services.FirebaseAuth, logger utils.Logger) FirebaseMiddleware {
	return FirebaseMiddleware{
		client: frsAuth,
		logger: logger,
	}
}

func (ptrFrsMiddleware FirebaseMiddleware) HandleAuthWithRoles(roles ...string) gin.HandlerFunc {
	return func(gCtx *gin.Context) {
		idToken, err := ptrFrsMiddleware.getTokenFromHeaders(gCtx)
		if err != nil {
			gCtx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized"})
			gCtx.Abort()
			return
		}

		token, err := ptrFrsMiddleware.client.VerifyIDToken(context.Background(), idToken)
		if err != nil {
			ptrFrsMiddleware.logger.Info(gin.H{"message": "Unauthorized", "error": err.Error()})
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
			if ok := ptrFrsMiddleware.checkRoleIsValid(roles, token); !ok {
				gCtx.JSON(http.StatusForbidden, gin.H{"message": "Invalid user roles"})
				gCtx.Abort()
				return
			}
		}

		gCtx.Set(utils.UID, token.UID)
		gCtx.Set(utils.ROLES, token.Claims[utils.ROLES])
		gCtx.Next()
	}
}

func (ptrFrsMiddleware FirebaseMiddleware) getTokenFromHeaders(c *gin.Context) (string, error) {
	bearer := c.GetHeader("Authorization")
	if bearer == "" {
		return "", ErrNoToken
	}
	token := strings.TrimPrefix(bearer, "Bearer ")
	return token, nil
}

func (ptrFrsMiddleware FirebaseMiddleware) checkRoleIsValid(roles []string, token *auth.Token) bool {
	for _, val := range roles {
		if token.Claims[utils.ROLES] == val {
			return true
		}
	}
	return false
}
