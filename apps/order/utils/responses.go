package utils

type Result[T any] struct {
	Response InnerResult[T] `json:"response"`
}

type InnerResult[T any] struct {
	Head map[string]interface{} `json:"head"`
	Body T                      `json:"body"`
}

type BaseSnapResponse struct {
	ResponseCode    string `json:"responseCode"`
	ResponseMessage string `json:"responseMessage"`
}

type SnapApplyToken struct {
	BaseSnapResponse
	AccessToken            string         `json:"accessToken"`
	AccessTokenExpiryTime  string         `json:"accessTokenExpiryTime"`
	TokenType              string         `json:"tokenType"`
	RefreshToken           string         `json:"refreshToken"`
	RefreshTokenExpiryTime string         `json:"refreshTokenExpiryTime"`
	AdditionalInfo         AdditionalInfo `json:"additionalInfo"`
}

type SnapCancelOrder struct {
	BaseSnapResponse
	OriginalPartnerReferenceNo string `json:"originalPartnerReferenceNo"`
	OriginalReferenceNo        string `json:"originalReferenceNo"`
	OriginalExternalId         string `json:"originalExternalId"`
	CancelTime                 string `json:"cancelTime"`
	TransactionDate            string `json:"transactionDate"`
}

type AdditionalInfo struct {
	UserInfo UserInfo `json:"userInfo"`
}

type SnapGetToken struct {
	BaseSnapResponse
	AccessToken string `json:"accessToken"`
	TokenType   string `json:"tokenType"`
	ExpiresIn   string `json:"expiresIn"`
}

type DirectDebit struct {
	BaseSnapResponse
	ReferenceNo        string `json:"referenceNo"`
	PartnerReferenceNo string `json:"partnerReferenceNo"`
	WebRedirectUrl     string `json:"webRedirectUrl"`
}

type ApplyToken struct {
	ResultInfo      ResultInfo      `json:"resultInfo"`
	AccessTokenInfo AccessTokenInfo `json:"accessTokenInfo"`
	UserInfo        UserInfo        `json:"userInfo"`
}

type UserProfile struct {
	ResultInfo        ResultInfo          `json:"resultInfo"`
	UserResourcesInfo []UserResourcesInfo `json:"userResourcesInfos"`
}

type CancelOrder struct {
	ResultInfo      ResultInfo `json:"resultInfo"`
	AcquirementId   string     `json:"acquirementId"`
	MerchantTransId string     `json:"merchantTransId"`
	CancelTime      string     `json:"cancelTime"`
}

type CreateOrder struct {
	ResultInfo      ResultInfo `json:"resultInfo"`
	MerchantTransId string     `json:"merchantTransId"`
	AcquirementId   string     `json:"acquirementId"`
	CheckoutUrl     string     `json:"checkoutUrl"`
}

type UserResourcesInfo struct {
	ResourceType string `json:"resourceType"`
	Value        string `json:"value"`
}

type UserInfo struct {
	PublicUserId string `json:"publicUserId"`
}

type AccessTokenInfo struct {
	AccessToken  string `json:"accessToken"`
	ExpiresIn    string `json:"expiresIn"`
	RefreshToken string `json:"refreshToken"`
	ReExpiresIn  string `json:"reExpiresIn"`
	TokenStatus  string `json:"tokenStatus"`
}

type ResultInfo struct {
	ResultStatus  string `json:"resultStatus"`
	ResultCodeId  string `json:"resultCodeId"`
	ResultCode    string `json:"resultCode"`
	ResultMessage string `json:"resultMsg"`
}
