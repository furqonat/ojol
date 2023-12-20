package services

import "apps/utility/utils"

type OAuthService struct {
	logger utils.Logger
	dana   DanaService
}

func NewOauthService(logger utils.Logger, dana DanaService) OAuthService {
	return OAuthService{
		logger: logger,
		dana:   dana,
	}
}

func (auth OAuthService) ApplyAccessToken(accessToken string) {
	auth.dana.ApplyAccessToken(accessToken)
}
