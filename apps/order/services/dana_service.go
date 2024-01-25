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

func (dana DanaService) CreateNewOrder(
	expiryTime,
	transactionType,
	title,
	orderID string,
	amountInCent int,
	riskObjectID,
	riskObjectCode,
	riskObjectOperator,
	accessToken string,
) (*utils.CreateOrder, error) {
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

func (dana DanaService) CancelOrder(orderId string, reason string) (*utils.CancelOrder, error) {
	requestData := map[string]interface{}{
		"originalPartnerReferenceNo": orderId,
		"merchantId":                 utils.MerchantID,
		"reason":                     reason,
	}

	resp, err := dana.GetAccessToken()
	if err != nil {
		return nil, err
	}
	response, errResp := dana.danaApi.SnapTransaction("/v1.0/debit/cancel.htm", requestData, "", resp.AccessToken)

	if errResp != nil {
		return nil, errResp
	}

	result := utils.SnapCancelOrder{}

	errParse := json.Unmarshal(response, &result)
	if errParse != nil {
		return nil, errParse
	}
	return &utils.CancelOrder{
		AcquirementId:   result.OriginalPartnerReferenceNo,
		MerchantTransId: result.OriginalReferenceNo,
		CancelTime:      result.CancelTime,
	}, nil
}
