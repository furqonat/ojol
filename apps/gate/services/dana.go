package services

import (
	"apps/gate/utils"
	"encoding/json"
	"errors"
	"fmt"
	"time"
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

	uri := fmt.Sprintf("%s/v1.0/get-auth-code?timestamp=%s&partnerId=%s&scopes=%s&state=%s&channelId=DANAID&externalId=%s&redirectUrl=%s",
		dana.danaApi.GetWebURL(),
		time.Now().Format(utils.DanaDateFormat),
		utils.ClientID,
		utils.OAuthScope,
		state,
		utils.MerchantID,
		utils.OAuthRedirectURL,
	)

	return uri
}

func (dana DanaService) GetAccessToken() (*utils.SnapGetToken, error) {

	requestData := map[string]interface{}{
		"grantType": "client_credentials",
	}

	response, err := dana.danaApi.SnapApplyToken("/v1.0/access-token/b2b.htm", requestData)
	if err != nil {
		return nil, err
	}
	result := utils.SnapGetToken{}
	parser := json.Unmarshal(response, &result)
	if parser != nil {
		return nil, parser
	}
	if result.ResponseMessage != "Successful" {
		errMsg := fmt.Sprintf("Error: %s", result.ResponseMessage)
		return nil, errors.New(errMsg)
	}
	return &result, nil

}

func (dana DanaService) BalanceInquiry(accessToken string) (*utils.BalanceInquiry, error) {
	requestData := map[string]interface{}{
		"partnerReferenceNo": "2020102900000000000001",
		"balanceTypes":       []string{"BALANCE"},
		"additionalInfo": map[string]interface{}{
			"accessToken": accessToken,
		},
	}
	resp, err := dana.GetAccessToken()
	if err != nil {
		dana.logger.Info(err.Error())
		return nil, err
	}
	response, err := dana.danaApi.SnapTransaction("/v1.0/balance-inquiry.htm", requestData, accessToken, resp.AccessToken)
	if err != nil {
		dana.logger.Info(err.Error())
		return nil, err
	}
	result := utils.BalanceInquiry{}
	parser := json.Unmarshal(response, &result)
	if parser != nil {
		dana.logger.Info(err.Error())
		return nil, parser
	}
	if result.ResponseMessage != "Successful" {
		errMsg := fmt.Sprintf("Error: %s", result.ResponseMessage)
		return nil, errors.New(errMsg)
	}
	return &result, nil
}

func (dana DanaService) ApplyAccessToken(authCode string) (*utils.SnapApplyToken, error) {
	requestData := map[string]interface{}{
		"grantType":      "AUTHORIZATION_CODE",
		"authCode":       authCode,
		"refreshToken":   "",
		"additionalInfo": map[string]interface{}{},
	}
	response, err := dana.danaApi.SnapApplyToken("/v1.0/access-token/b2b2c.htm", requestData)
	if err != nil {
		return nil, err
	}
	result := utils.SnapApplyToken{}
	parser := json.Unmarshal(response, &result)
	if parser != nil {
		return nil, parser
	}
	if result.ResponseMessage != "Successful" {
		errMsg := fmt.Sprintf("Error: %s", result.ResponseMessage)
		return nil, errors.New(errMsg)
	}
	return &result, nil
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

func (dana DanaService) RequestWithdraw(phoneNumber string, amount int, trxId string) (*utils.WithdrawRequest, error) {
	timestamp := dana.danaApi.GetDateNow()
	amountString := fmt.Sprintf("%.2f", float64(amount)/100)
	requestData := map[string]interface{}{
		"partnerReferenceNo": trxId,
		"customerNumber":     phoneNumber,
		"amount": map[string]interface{}{
			"value":    amountString,
			"currency": "IDR",
		},
		"transactionDate": timestamp,
		"additionalInfo": map[string]interface{}{
			"fundType":     "AGENT_TOPUP_FOR_USER_SETTLE",
			"chargeTarget": "MERCHANT",
		},
	}
	resp, err := dana.GetAccessToken()
	if err != nil {
		return nil, err
	}
	response, err := dana.danaApi.SnapTransaction("/v1.0/emoney/account-inquiry.htm", requestData, "", resp.AccessToken)
	if err != nil {
		return nil, err
	}
	result := utils.WithdrawRequest{}
	if errParse := json.Unmarshal(response, &result); errParse != nil {
		return nil, errParse
	}

	if result.ResponseMessage != "Successful" {
		dana.logger.Info(result)
		return nil, errors.New(fmt.Sprintf("Error: %s", response))
	}

	return &result, nil
}

func (dana DanaService) CreateNewOrder(expiryTime, transactionType, title, orderID string, amountInCent int, riskObjectID, riskObjectCode, riskObjectOperator, accessToken string) (*utils.CreateOrder, error) {
	amountString := fmt.Sprintf("%.2f", float64(amountInCent)/100)
	requestData := map[string]interface{}{
		"partnerReferenceNo": orderID,
		"merchantId":         utils.MerchantID,
		"amount": map[string]interface{}{
			"value":    amountString,
			"currency": "IDR",
		},
		"validUpTo":         expiryTime,
		"pointOfInitiation": "Mobile App",
		"urlParams": []map[string]interface{}{
			{
				"url":        utils.AcquirementPayReturnURL,
				"type":       "PAY_RETURN",
				"isDeeplink": "Y",
			},
			{
				"url":        utils.AcquirementPayReturnURL,
				"type":       "NOTIFICATION",
				"isDeeplink": "Y",
			},
		},
		"additionalInfo": map[string]interface{}{
			"supportDeepLinkCheckoutUrl": true,
			"productCode":                "51051000100000000001",
			"order": map[string]interface{}{
				"orderTitle":        title,
				"merchantTransType": "type",
				"orderMemo":         "Memo",
				"createdTime":       "2020-12-23T08:31:11+07:00",
				"extendInfo":        "",
			},
			"mcc": utils.MerchantMCC,
			"envInfo": map[string]interface{}{
				"sourcePlatform":    "IPG",
				"terminalType":      "SYSTEM",
				"orderTerminalType": "WEB",
			},
			"extendInfo": "",
		},
	}

	resp, err := dana.GetAccessToken()
	if err != nil {
		return nil, err
	}

	response, err := dana.danaApi.SnapTransaction("/v1.0/debit/payment.htm", requestData, accessToken, resp.AccessToken)

	if err != nil {
		return nil, err
	}

	result := utils.DirectDebit{}
	errParse := json.Unmarshal(response, &result)
	if errParse != nil {
		return nil, errParse
	}

	if result.ResponseMessage != "Successful" {
		errMsg := fmt.Sprintf("Error: %s, message: %s", result.BaseSnapResponse.ResponseCode, result.ResponseMessage)
		return nil, errors.New(errMsg)
	}

	return &utils.CreateOrder{
		CheckoutUrl:     result.WebRedirectUrl,
		MerchantTransId: result.PartnerReferenceNo,
		AcquirementId:   result.ReferenceNo,
	}, nil
}
