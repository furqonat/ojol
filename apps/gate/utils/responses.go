package utils

import "time"

type Result[T any] struct {
	Response InnerResult[T] `json:"response"`
}

type InnerResult[T any] struct {
	Head map[string]interface{} `json:"head"`
	Body T                      `json:"body"`
}

type ApplyToken struct {
	ResultInfo      ResultInfo      `json:"resultInfo"`
	AccessTokenInfo AccessTokenInfo `json:"accessTokenInfo"`
	UserInfo        UserInfo        `json:"userInfo"`
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

type BalanceInquiry struct {
	BaseSnapResponse
	Name               string        `json:"name"`
	ReferenceNo        string        `json:"referenceNo"`
	PartnerReferenceNo string        `json:"partnerReferenceNo"`
	AccountInfo        []AccountInfo `json:"accountInfos"`
}

type AccountInfo struct {
	BalanceType string `json:"balanceType"`
	Amount      Amount `json:"amount"`
	FloatAmount Amount `json:"floatAmount"`
	HoldAmount  Amount `json:"holdAmount"`
}

type Amount struct {
	Value    string `json:"value"`
	Currency string `json:"currency"`
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

type AdditionalInfo struct {
	UserInfo UserInfo `json:"userInfo"`
}

type RequestWithdrawType struct {
	ResultInfo  ResultInfo `json:"resultInfo"`
	FundOrderId string     `json:"fundOrderId"`
	RequestId   string     `json:"requestId"`
}

type UserProfile struct {
	ResultInfo        ResultInfo          `json:"resultInfo"`
	UserResourcesInfo []UserResourcesInfo `json:"userResourceInfos"`
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
type LogoURLMap struct {
	PCLOGO     string `json:"PC_LOGO"`
	LOGO       string `json:"LOGO"`
	MOBILELOGO string `json:"MOBILE_LOGO"`
}
type Certificate struct {
	CertificateNo   string `json:"certificateNo"`
	CertificateType string `json:"certificateType"`
}
type RegisteredAddress struct {
	Address1           string `json:"address1"`
	Address2           string `json:"address2"`
	Country            string `json:"country"`
	Province           string `json:"province"`
	City               string `json:"city"`
	Area               string `json:"area"`
	Zipcode            string `json:"zipcode"`
	ContactAddressType string `json:"contactAddressType"`
}

type BusinessAddress struct {
	Address1           string `json:"address1"`
	Address2           string `json:"address2"`
	Country            string `json:"country"`
	Province           string `json:"province"`
	City               string `json:"city"`
	Area               string `json:"area"`
	Zipcode            string `json:"zipcode"`
	ContactAddressType string `json:"contactAddressType"`
}

type CorporateOfficialName struct {
	FirstName string `json:"firstName"`
	LastName  string `json:"lastName"`
}

type CorporateCertificate struct {
	CertificateNo   string `json:"certificateNo"`
	CertificateType string `json:"certificateType"`
}

type ContactMobileNo struct {
	MobileNo   string `json:"mobileNo"`
	IsVerified string `json:"isVerified"`
}

type Accounts struct {
	AccountNo          string `json:"accountNo"`
	Status             string `json:"status"`
	DebitFreezeStatus  string `json:"debitFreezeStatus"`
	CreditFreezeStatus string `json:"creditFreezeStatus"`
	TotalAmount        string `json:"totalAmount"`
	AvailableAmount    string `json:"availableAmount"`
	Currency           string `json:"currency"`
	AccountType        string `json:"accountType"`
}

type TaxAddress struct {
	Address1           string `json:"address1"`
	Address2           string `json:"address2"`
	Country            string `json:"country"`
	Province           string `json:"province"`
	City               string `json:"city"`
	Area               string `json:"area"`
	Zipcode            string `json:"zipcode"`
	ContactAddressType string `json:"contactAddressType"`
}

type ContactEmail struct {
	Email string `json:"email"`
}

type MerchantQuery struct {
	ResultInfo          ResultInfo `json:"resultInfo"`
	MerchantInformation any        `json:"merchantResourceInformations"`
}

type MerchantInformation struct {
	PhoneNumber           string                `json:"phoneNumber"`
	MerchantID            string                `json:"merchantId"`
	MerchantType          string                `json:"merchantType"`
	MerchantSubType       string                `json:"merchantSubType"`
	MccCodes              []string              `json:"mccCodes"`
	LogoURL               string                `json:"logoUrl"`
	LogoUrlMap            LogoURLMap            `json:"logoUrlMap"`
	ShortNameCode         string                `json:"shortNameCode"`
	OfficialName          string                `json:"officialName"`
	EnglishName           string                `json:"englishName"`
	LocalName             string                `json:"localName"`
	Certificate           Certificate           `json:"certificate"`
	CertificateUrls       []string              `json:"certificateUrls"`
	CertificateExpiryDate time.Time             `json:"certificateExpiryDate"`
	RegisteredAddress     RegisteredAddress     `json:"registeredAddress"`
	BusinessAddress       BusinessAddress       `json:"businessAddress"`
	OfficeTelephone       string                `json:"officeTelephone"`
	FaxTelephone          string                `json:"faxTelephone"`
	CorporateOfficialName CorporateOfficialName `json:"corporateOfficialName"`
	CorporateCertificate  CorporateCertificate  `json:"corporateCertificate"`
	ContactMobileNo       ContactMobileNo       `json:"contactMobileNo"`
	ContactTelephone      string                `json:"contactTelephone"`
	ContactEmail          ContactEmail          `json:"contactEmail"`
	CreatedTime           time.Time             `json:"createdTime"`
	ModifiedTime          time.Time             `json:"modifiedTime"`
	MerchantStatus        string                `json:"merchantStatus"`
	RegisterSource        string                `json:"registerSource"`
	SizeType              string                `json:"sizeType"`
	PlatformMid           string                `json:"platformMid"`
	TaxNo                 string                `json:"taxNo"`
	Accounts              []Accounts            `json:"accounts"`
	BrandName             string                `json:"brandName"`
	TaxAddress            TaxAddress            `json:"taxAddress"`
}
