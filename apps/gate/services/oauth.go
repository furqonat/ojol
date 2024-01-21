package services

import (
	"apps/gate/db"
	"apps/gate/utils"
	"context"
	"errors"
	"fmt"
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
	expiredIn, errExpr := time.Parse(utils.DanaDateFormat, resp.AccessTokenExpiryTime)
	if errExpr != nil {
		return nil, errExpr
	}
	reExpired, errReExpr := time.Parse(utils.DanaDateFormat, resp.RefreshTokenExpiryTime)
	if errReExpr != nil {
		return nil, errReExpr
	}
	ava, errT := auth.database.DanaToken.FindUnique(db.DanaToken.CustomerID.Equals(customerId)).Exec(context.Background())
	if errT == nil {
		tkn, errTkn := auth.database.DanaToken.FindUnique(
			db.DanaToken.ID.Equals(ava.ID),
		).Update(
			db.DanaToken.AccessToken.Set(resp.AccessToken),
			db.DanaToken.ExpiresIn.Set(expiredIn),
			db.DanaToken.RefreshToken.Set(resp.RefreshToken),
			db.DanaToken.ReExpiresIn.Set(reExpired),
			db.DanaToken.TokenStatus.Set(resp.TokenType),
			db.DanaToken.DanaUserID.Set(resp.AdditionalInfo.UserInfo.PublicUserId),
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
		db.DanaToken.AccessToken.Set(resp.AccessToken),
		db.DanaToken.ExpiresIn.Set(expiredIn),
		db.DanaToken.RefreshToken.Set(resp.RefreshToken),
		db.DanaToken.ReExpiresIn.Set(reExpired),
		db.DanaToken.TokenStatus.Set(resp.TokenType),
		db.DanaToken.DanaUserID.Set(resp.AdditionalInfo.UserInfo.PublicUserId),
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
		db.Customer.DanaToken.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	danaToken, ok := customer.DanaToken()
	if !ok {
		return nil, errors.New("unable fetch dana token")
	}
	auth.logger.Info(danaToken)
	dana, errDana := auth.dana.GetUserProfile(danaToken.AccessToken)
	if errDana != nil {
		auth.logger.Info(err)
		return nil, errDana
	}
	return dana.UserResourcesInfo, nil
}

func (auth OAuthService) MerchantApplyAccessToken(accessToken string, merchantId string) (*string, error) {
	resp, err := auth.dana.ApplyAccessToken(accessToken)
	if err != nil {
		return nil, err
	}
	expiredIn, errExpr := time.Parse(utils.DanaDateFormat, resp.AccessTokenExpiryTime)
	if errExpr != nil {
		return nil, errExpr
	}
	reExpired, errReExpr := time.Parse(utils.DanaDateFormat, resp.RefreshTokenExpiryTime)
	if errReExpr != nil {
		return nil, errReExpr
	}
	ava, errT := auth.database.DanaTokenMerchant.FindUnique(db.DanaTokenMerchant.MerchantID.Equals(merchantId)).Exec(context.Background())
	if errT == nil {
		tkn, errTkn := auth.database.DanaTokenMerchant.FindUnique(
			db.DanaTokenMerchant.ID.Equals(ava.ID),
		).Update(
			db.DanaTokenMerchant.AccessToken.Set(resp.AccessToken),
			db.DanaTokenMerchant.ExpiresIn.Set(expiredIn),
			db.DanaTokenMerchant.RefreshToken.Set(resp.RefreshToken),
			db.DanaTokenMerchant.ReExpiresIn.Set(reExpired),
			db.DanaTokenMerchant.TokenStatus.Set(resp.TokenType),
			db.DanaTokenMerchant.DanaUserID.Set(resp.AdditionalInfo.UserInfo.PublicUserId),
		).Exec(context.Background())
		if errTkn != nil {
			auth.logger.Info(errTkn)

			return nil, errTkn
		}
		auth.logger.Info(tkn)

		return &tkn.ID, nil
	}
	dbToken, errDanaToken := auth.database.DanaTokenMerchant.CreateOne(
		db.DanaTokenMerchant.AccessToken.Set(resp.AccessToken),
		db.DanaTokenMerchant.ExpiresIn.Set(expiredIn),
		db.DanaTokenMerchant.RefreshToken.Set(resp.RefreshToken),
		db.DanaTokenMerchant.ReExpiresIn.Set(reExpired),
		db.DanaTokenMerchant.TokenStatus.Set(resp.TokenType),
		db.DanaTokenMerchant.DanaUserID.Set(resp.AdditionalInfo.UserInfo.PublicUserId),
		db.DanaTokenMerchant.Merchant.Link(db.Merchant.ID.Equals(merchantId)),
	).Exec(context.Background())
	if errDanaToken != nil {
		auth.logger.Info(errDanaToken)

		return nil, errDanaToken
	}

	auth.logger.Info(dbToken)

	return &dbToken.ID, nil
}

func (auth OAuthService) MerchantGenerateSignUrl(merchantId string) string {
	return auth.dana.GenerateSignInUrl(fmt.Sprintf("merch-%s", merchantId))
}

func (auth OAuthService) MerchantGetDanaProfile(merchantId string) ([]utils.UserResourcesInfo, error) {
	customer, err := auth.database.Merchant.FindUnique(
		db.Merchant.ID.Equals(merchantId),
	).With(
		db.Merchant.DanaToken.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	danaToken, ok := customer.DanaToken()
	if !ok {
		return nil, errors.New("unable fetch dana token")
	}
	auth.logger.Info(danaToken)
	dana, errDana := auth.dana.GetUserProfile(danaToken.AccessToken)
	if errDana != nil {
		auth.logger.Info(err)
		return nil, errDana
	}
	return dana.UserResourcesInfo, nil
}

func (auth OAuthService) DriverApplyAccessToken(accessToken string, driverId string) (*string, error) {
	resp, err := auth.dana.ApplyAccessToken(accessToken)
	if err != nil {
		return nil, err
	}
	expiredIn, errExpr := time.Parse(utils.DanaDateFormat, resp.AccessTokenExpiryTime)
	if errExpr != nil {
		return nil, errExpr
	}
	reExpired, errReExpr := time.Parse(utils.DanaDateFormat, resp.RefreshTokenExpiryTime)
	if errReExpr != nil {
		return nil, errReExpr
	}
	ava, errT := auth.database.DanaTokenDriver.FindUnique(
		db.DanaTokenDriver.DriverID.Equals(driverId),
	).Exec(context.Background())
	if errT == nil {
		tkn, errTkn := auth.database.DanaTokenDriver.FindUnique(
			db.DanaTokenDriver.ID.Equals(ava.ID),
		).Update(
			db.DanaTokenDriver.AccessToken.Set(resp.AccessToken),
			db.DanaTokenDriver.ExpiresIn.Set(expiredIn),
			db.DanaTokenDriver.RefreshToken.Set(resp.RefreshToken),
			db.DanaTokenDriver.ReExpiresIn.Set(reExpired),
			db.DanaTokenDriver.TokenStatus.Set(resp.TokenType),
			db.DanaTokenDriver.DanaUserID.Set(resp.AdditionalInfo.UserInfo.PublicUserId),
		).Exec(context.Background())
		if errTkn != nil {
			auth.logger.Info(errTkn)

			return nil, errTkn
		}
		auth.logger.Info(tkn)

		return &tkn.ID, nil
	}
	dbToken, errDanaToken := auth.database.DanaTokenDriver.CreateOne(
		db.DanaTokenDriver.AccessToken.Set(resp.AccessToken),
		db.DanaTokenDriver.ExpiresIn.Set(expiredIn),
		db.DanaTokenDriver.RefreshToken.Set(resp.RefreshToken),
		db.DanaTokenDriver.ReExpiresIn.Set(reExpired),
		db.DanaTokenDriver.TokenStatus.Set(resp.TokenType),
		db.DanaTokenDriver.DanaUserID.Set(resp.AdditionalInfo.UserInfo.PublicUserId),
		db.DanaTokenDriver.Driver.Link(db.Driver.ID.Equals(driverId)),
	).Exec(context.Background())
	if errDanaToken != nil {
		auth.logger.Info(errDanaToken)

		return nil, errDanaToken
	}

	auth.logger.Info(dbToken)

	return &dbToken.ID, nil
}

func (auth OAuthService) DriverGenerateSignUrl(driverId string) string {
	return auth.dana.GenerateSignInUrl(fmt.Sprintf("dri-%s", driverId))
}

func (auth OAuthService) DriverGetDanaProfile(driverId string) ([]utils.UserResourcesInfo, error) {
	driver, err := auth.database.Driver.FindUnique(
		db.Driver.ID.Equals(driverId),
	).With(
		db.Driver.DanaToken.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	danaToken, ok := driver.DanaToken()
	if !ok {
		return nil, errors.New("unable fetch dana token")
	}
	auth.logger.Info(danaToken)
	dana, errDana := auth.dana.GetUserProfile(danaToken.AccessToken)
	if errDana != nil {
		auth.logger.Info(err)
		return nil, errDana
	}
	return dana.UserResourcesInfo, nil
}
