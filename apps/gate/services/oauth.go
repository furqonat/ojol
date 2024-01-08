package services

import (
	"apps/gate/db"
	"apps/gate/utils"
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
	ava, errT := auth.database.DanaToken.FindFirst(db.DanaToken.CustomerID.Equals(customerId)).Exec(context.Background())
	if errT == nil {
		tkn, errTkn := auth.database.DanaToken.FindUnique(
			db.DanaToken.ID.Equals(ava.ID),
		).Update(
			db.DanaToken.AccessToken.Set(resp.AccessTokenInfo.AccessToken),
			db.DanaToken.ExpiresIn.Set(expiredIn),
			db.DanaToken.RefreshToken.Set(resp.AccessTokenInfo.RefreshToken),
			db.DanaToken.ReExpiresIn.Set(reExpired),
			db.DanaToken.TokenStatus.Set(resp.AccessTokenInfo.TokenStatus),
			db.DanaToken.DanaUserID.Set(resp.UserInfo.PublicUserId),
		).Exec(context.Background())
		if errTkn != nil {
			auth.logger.Info(errTkn)

			return nil, errTkn
		}
		auth.logger.Info(tkn)

		return &tkn.ID, nil
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
		auth.logger.Info(errDanaToken)

		return nil, errDanaToken
	}

	auth.logger.Info(dbToken)

	return &dbToken.ID, nil
}

func (auth OAuthService) GenerateSignUrl(customerId string) string {
	return auth.dana.GenerateSignInUrl(customerId)
}

func (auth OAuthService) GetDanaProfile(customerId string) ([]utils.UserResourcesInfo, error) {
	customer, err := auth.database.Customer.FindUnique(
		db.Customer.ID.Equals(customerId),
	).With(
		db.Customer.DanaToken.Fetch().Take(1),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	danaToken := customer.DanaToken()[0]
	auth.logger.Info(danaToken)
	dana, errDana := auth.dana.GetUserProfile(danaToken.AccessToken)
	if errDana != nil {
		auth.logger.Info(err)
		return nil, errDana
	}
	return dana.UserResourcesInfo, nil
}
