package services

import (
	"apps/order/utils"
	"errors"
	"fmt"
)

type DanaService struct {
	danaApi utils.DanaApi
	logger  utils.Logger
}

func NewDanaService(dana utils.DanaApi, logger utils.Logger) DanaService {
	return DanaService{
		danaApi: dana,
		logger:  logger,
	}
}

func (dana DanaService) CreateNewOrder(expiryTime, transactionType, title, orderID string, amountInCent int, riskObjectID, riskObjectCode, riskObjectOperator, accessToken string) (map[string]interface{}, error) {
	timestam := dana.danaApi.GetDateNow()
	guid := dana.danaApi.GenerateGUID()

	requestData := map[string]interface{}{
		"head": map[string]interface{}{
			"version":      "2.0",
			"function":     "dana.acquiring.order.createOrder",
			"clientId":     utils.ClientID,
			"clientSecret": utils.ClientSecret,
			"reqTime":      timestam,
			"reqMsgId":     guid,
			"accessToken":  accessToken,
			"reserve":      "{}",
		},
		"body": map[string]interface{}{
			"envInfo": map[string]interface{}{
				"terminalType":       "SYSTEM",
				"osType":             "",
				"extendInfo":         "",
				"orderOsType":        "",
				"sdkVersion":         "",
				"websiteLanguage":    "",
				"tokenId":            "",
				"sessionId":          "",
				"appVersion":         "",
				"merchantAppVersion": "",
				"clientKey":          "",
				"orderTerminalType":  "SYSTEM",
				"clientIp":           "",
				"sourcePlatform":     "IPG",
			},
			"order": map[string]interface{}{
				"expiryTime":        expiryTime,
				"merchantTransType": transactionType,
				"orderTitle":        title,
				"merchantTransId":   orderID,
				"orderMemo":         "",
				"createdTime":       timestam,
				"orderAmount": map[string]interface{}{
					"value":    amountInCent,
					"currency": "IDR",
				},
				"goods": []map[string]interface{}{
					{
						"unit":     "",
						"category": "",
						"price": map[string]interface{}{
							"value":    amountInCent,
							"currency": "IDR",
						},
						"merchantShippingId": "",
						"merchantGoodsId":    "",
						"description":        title,
						"snapshotUrl":        "",
						"quantity":           "",
						"extendInfo":         fmt.Sprintf("{'objectId':'%s','objectCode':'%s','objectOperator':'%s'}", riskObjectID, riskObjectCode, riskObjectOperator),
					},
				},
			},
			"productCode": "51051000100000000001",
			"mcc":         utils.MerchantMCC,
			"merchantId":  utils.MerchantID,
			"extendInfo":  "",
			"notificationUrls": []map[string]interface{}{
				{
					"type": "PAY_RETURN",
					"url":  utils.AcquirementPayReturnURL,
				},
				{
					"type": "NOTIFICATION",
					"url":  utils.AcquirementNotificationURL,
				},
			},
		},
	}

	response, err := dana.danaApi.New("/dana/acquiring/order/createOrder.htm", requestData)

	if err != nil {
		return map[string]interface{}{}, err
	}

	resultInfo, isSuccess := dana.danaApi.IsResponseSuccess(response)

	if isSuccess {
		acquirementID := response["response"].(map[string]interface{})["body"].(map[string]interface{})["acquirementId"].(string)
		checkoutURL := response["response"].(map[string]interface{})["body"].(map[string]interface{})["checkoutUrl"].(string)

		return map[string]interface{}{
			"acquirementId": acquirementID,
			"checkoutUrl":   checkoutURL,
			"resultInfo":    resultInfo,
		}, nil
	}
	errMsg := fmt.Sprintf("error create dana api notif=%s, pay=%s, %s", timestam, guid, response["response"])
	return response["response"].(map[string]interface{})["body"].(map[string]interface{}), errors.New(errMsg)
}
