package services

import (
	"apps/utility/db"
	"apps/utility/utils"
	"context"
	"time"
)

type OAuthService struct {
	logger   utils.Logger
	database utils.Database
	dana     DanaService
}

func NewOauthService(logger utils.Logger, database utils.Database, dana DanaService) OAuthService {
	return OAuthService{
		logger:   logger,
		database: database,
		dana:     dana,
	}
}

func (auth OAuthService) ApplyAccessToken(accessToken string, customerId string) (*string, error) {
	resp, err := auth.dana.ApplyAccessToken(accessToken)
	if err != nil {
		return nil, err
	}
	expiredIn, errExpr := time.Parse(utils.DanaDateFormat, resp.AccessTokenInfo.ExpiresIn)
	if errExpr != nil {
		return nil, errExpr
	}
	reExpired, errReExpr := time.Parse(utils.DanaDateFormat, resp.AccessTokenInfo.ReExpiresIn)
	if errReExpr != nil {
		return nil, errReExpr
	}
	dbToken, errDanaToken := auth.database.DanaToken.CreateOne(
		db.DanaToken.Customer.Link(db.Customer.ID.Equals(customerId)),
		db.DanaToken.AccessToken.Set(resp.AccessTokenInfo.AccessToken),
		db.DanaToken.ExpiresIn.Set(expiredIn),
		db.DanaToken.RefreshToken.Set(resp.AccessTokenInfo.RefreshToken),
		db.DanaToken.ReExpiresIn.Set(reExpired),
		db.DanaToken.TokenStatus.Set(resp.AccessTokenInfo.TokenStatus),
		db.DanaToken.DanaUserID.Set(resp.UserInfo.PublicUserId),
	).Exec(context.Background())
	if errDanaToken != nil {
		return nil, errDanaToken
	}

	return &dbToken.ID, nil
}

func (auth OAuthService) GenerateSignUrl() string {
	return auth.dana.GenerateSignInUrl()
}
