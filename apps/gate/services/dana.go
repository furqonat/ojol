package services

import (
	"apps/gate/utils"
	"encoding/json"
	"errors"
	"fmt"
	"net/url"
)

type DanaService struct {
	danaApi utils.Dana
	logger  utils.Logger
}

func NewDanaService(dana utils.Dana, logger utils.Logger) DanaService {
	return DanaService{
		danaApi: dana,
		logger:  logger,
	}
}

func (dana DanaService) GenerateSignInUrl(state string) string {
	guid := dana.danaApi.GenerateGUID()

	uri := fmt.Sprintf("%s/d/portal/oauth?clientId=%s&scopes=%s&requestId=%s&state=%s&terminalType=%s&redirectUrl=%s",
		dana.danaApi.GetWebURL(),
		utils.ClientID,
		utils.OAuthScope,
		guid,
		state,
		utils.TerminalType,
		url.QueryEscape(utils.OAuthRedirectURL),
	)

	return uri
}

func (dana DanaService) ApplyAccessToken(authCode string) (*utils.ApplyToken, error) {
	timestamp := dana.danaApi.GetDateNow()
	guid := dana.danaApi.GenerateGUID()
	requestData := map[string]interface{}{
		"head": map[string]interface{}{
			"version":      "2.0",
			"function":     "dana.oauth.auth.applyToken",
			"clientId":     utils.ClientID,
			"clientSecret": utils.ClientSecret,
			"reqTime":      timestamp,
			"reqMsgId":     guid,
			"accessToken":  "",
			"reserve":      "{}",
		},
		"body": map[string]interface{}{
			"grantType": "AUTHORIZATION_CODE",
			"authCode":  authCode,
		},
	}
	response, err := dana.danaApi.New("/dana/oauth/auth/applyToken.htm", requestData)
	if err != nil {
		return nil, err
	}
	result := utils.Result[utils.ApplyToken]{}
	parser := json.Unmarshal(response, &result)
	if parser != nil {
		return nil, parser
	}
	if result.Response.Body.ResultInfo.ResultCode != "SUCCESS" {
		return nil, errors.New("unable apply access token")
	}
	return &result.Response.Body, nil
}

func (dana DanaService) GetUserProfile(accessToken string) (*utils.UserProfile, error) {

	guid := dana.danaApi.GenerateGUID()
	timestamp := dana.danaApi.GetDateNow()

	requestData := map[string]interface{}{
		"head": map[string]interface{}{
			"version":      "2.0",
			"function":     "dana.member.query.queryUserProfile",
			"clientId":     utils.ClientID,
			"clientSecret": utils.ClientSecret,
			"reqTime":      timestamp,
			"reqMsgId":     guid,
			"reserve":      "{}",
			"accessToken":  accessToken,
		},
		"body": map[string]interface{}{
			"userResources": []string{"BALANCE", "TRANSACTION_URL", "MASK_DANA_ID", "TOPUP_URL", "OTT"},
		},
	}

	response, err := dana.danaApi.New("/dana/member/query/queryUserProfile.htm", requestData)

	if err != nil {
		return nil, err
	}
	result := utils.Result[utils.UserProfile]{}
	errParse := json.Unmarshal(response, &result)
	if errParse != nil {
		return nil, errParse
	}
	if result.Response.Body.ResultInfo.ResultCode != "SUCCESS" {
		return nil, errors.New("unable to get user profile")
	}
	return &result.Response.Body, nil
}

func (dana DanaService) GetCompanyBallance() (*utils.MerchantQuery, error) {
	guid := dana.danaApi.GenerateGUID()
	timestamp := dana.danaApi.GetDateNow()

	requestData := map[string]interface{}{
		"head": map[string]interface{}{
			"version":      "2.0",
			"function":     "dana.merchant.queryMerchantResource",
			"clientId":     utils.ClientID,
			"clientSecret": utils.ClientSecret,
			"reqTime":      timestamp,
			"reqMsgId":     guid,
			"reserve":      "{}",
		},
		"body": map[string]interface{}{
			"requestMerchantId": utils.MerchantID,
			"merchantResourceInfoList": []string{
				"MERCHANT_AVAILABLE_BALANCE",
				"MERCHANT_DEPOSIT_BALANCE",
				"MERCHANT_TOTAL_BALANCE",
			},
		},
	}
	response, err := dana.danaApi.New("/dana/merchant/queryMerchantResource.htm", requestData)

	if err != nil {
		return nil, err
	}
	result := utils.Result[utils.MerchantQuery]{}
	errParse := json.Unmarshal(response, &result)
	if errParse != nil {
		return nil, errParse
	}
	if result.Response.Body.ResultInfo.ResultCode != "SUCCESS" {
		dana.logger.Info(result.Response)
		return nil, errors.New(fmt.Sprintf("Error: %s", response))
	}
	return &result.Response.Body, nil
}

func (dana DanaService) RequestWithdraw(phoneNumber string, amount int) (*utils.RequestWithdrawType, error) {
	guid := dana.danaApi.GenerateGUID()
	timestamp := dana.danaApi.GetDateNow()

	requestData := map[string]interface{}{
		"head": map[string]interface{}{
			"version":      "2.0",
			"function":     "dana.fund.agent.topup.boost.topupForUser",
			"clientId":     utils.ClientID,
			"clientSecret": utils.ClientSecret,
			"reqTime":      timestamp,
			"reqMsgId":     guid,
			"reserve":      "{}",
		},
		"body": map[string]interface{}{
			"mobileNo": phoneNumber,
			"fundType": "AGENT_TOPUP_FOR_USER_SETTLE",
			"fundAmount": map[string]interface{}{
				"currency": "IDR",
				"value":    amount * 1000,
			},
			"requestId": guid,
			"agentMode": "NORMAL",
			"envInfo": map[string]interface{}{
				"terminalType":   "WEB",
				"sourcePlatform": "IPG",
			},
		},
	}
	response, err := dana.danaApi.New("/dana/fund/agent/topup/boost/topupForUser.htm", requestData)
	if err != nil {
		return nil, err
	}
	result := utils.Result[utils.RequestWithdrawType]{}
	if errParse := json.Unmarshal(response, &result); errParse != nil {
		return nil, errParse
	}

	if result.Response.Body.ResultInfo.ResultCode != "SUCCESS" {
		dana.logger.Info(result.Response)
		return nil, errors.New(fmt.Sprintf("Error: %s", response))
	}

	return &result.Response.Body, nil
}
