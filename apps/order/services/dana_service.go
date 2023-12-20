package services

import (
	"apps/order/utils"
	"encoding/json"
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

func (dana DanaService) CreateNewOrder(expiryTime, transactionType, title, orderID string, amountInCent int, riskObjectID, riskObjectCode, riskObjectOperator, accessToken string) (*utils.CreateOrder, error) {
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
		return nil, err
	}

	result := utils.Result[utils.CreateOrder]{}
	errParse := json.Unmarshal(response, &result)
	if errParse != nil {
		return nil, errParse
	}

	if result.Response.Body.ResultInfo.ResultCode != "SUCCESS" {
		return nil, errors.New("unable create order")
	}

	return &result.Response.Body, nil

}

func (dana DanaService) CancelOrder(orderId string, reason string) (*utils.CancelOrder, error) {
	timestam := dana.danaApi.GetDateNow()
	guid := dana.danaApi.GenerateGUID()
	requestData := map[string]interface{}{
		"head": map[string]interface{}{
			"version":      "2.0",
			"function":     "dana.acquiring.order.cancel",
			"clientId":     utils.ClientID,
			"clientSecret": utils.ClientSecret,
			"reqTime":      timestam,
			"reqMsgId":     guid,
			"reserve":      "{}",
		},
		"body": map[string]interface{}{
			"merchantId":      utils.MerchantID,
			"merchantTransId": orderId,
			"cancelReason":    reason,
		},
	}
	response, errResp := dana.danaApi.New("/dana/acquiring/order/cancel.htm", requestData)

	if errResp != nil {
		return nil, errResp
	}

	result := utils.Result[utils.CancelOrder]{}

	errParse := json.Unmarshal(response, &result)
	if errParse != nil {
		return nil, errParse
	}
	return &result.Response.Body, nil
}
