package middlewares

import (
	"apps/transactions/services"
	"apps/transactions/utils"
	"context"
	"errors"
	"net/http"

	"firebase.google.com/go/auth"

	"github.com/gin-gonic/gin"
)

var (
	ErrNoToken = errors.New("no token provided")
)

type FirebaseMiddleware struct {
	client services.FirebaseAuth
}

func NewFirebaseMiddleware(fa services.FirebaseAuth) FirebaseMiddleware {
	return FirebaseMiddleware{
		client: fa,
	}
}

func (m *FirebaseMiddleware) HandleAuthWithRoles(roles ...string) gin.HandlerFunc {
	return func(gCtx *gin.Context) {
		idToken, err := m.getTokenFromHeaders(gCtx)
		if err != nil {
			gCtx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized"})
			gCtx.Abort()
			return
		}

		token, err := m.client.VerifyIDToken(context.Background(), idToken)
		if err != nil {
			gCtx.JSON(http.StatusUnauthorized, gin.H{"message": "Unauthorized"})
			gCtx.Abort()
			return
		}

		if len(roles) < 1 {
			gCtx.JSON(http.StatusInternalServerError, gin.H{"message": "Server Error"})
			gCtx.Abort()
			return
		}

		if len(roles) > 0 {
			if ok := m.checkRoleIsValid(roles, token); !ok {
				gCtx.JSON(http.StatusForbidden, gin.H{"message": "Invalid user roles"})
				gCtx.Abort()
				return
			}
		}

		// Attach user information to the context for further processing
		gCtx.Set(utils.UID, token.UID)
		gCtx.Set(utils.ROLES, token.Claims[utils.ROLES])
		gCtx.Next()
	}
}

func (m *FirebaseMiddleware) getTokenFromHeaders(c *gin.Context) (string, error) {
	// Extract the token from the request, e.g., from headers, query parameters, or cookies
	// For example, you can extract it from the Authorization header like this:
	token := c.GetHeader("Authorization")
	if token == "" {
		return "", ErrNoToken
	}
	return token, nil
}

func (m *FirebaseMiddleware) checkRoleIsValid(roles []string, token *auth.Token) bool {
	for _, val := range roles {
		if token.Claims[utils.ROLES] == val {
			return true
		}
	}
	return false
}
