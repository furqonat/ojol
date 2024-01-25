package utils

type Request[T any] struct {
	Request   T      `json:"request"`
	Signature string `json:"signature"`
}

type FinishNotify struct {
	Head map[string]interface{} `json:"head"`
	Body BodyNotify             `json:"body"`
}

type FinishNotifySnap struct {
	OriginalPartnerReferenceNo string `json:"originalPartnerReferenceNo"`
	OriginalReferenceNo        string `json:"originalReferenceNo"`
	LatestTransactionStatus    string `json:"latestTransactionStatus"`
	FinishedTime               string `json:"finishedTime"`
}

type BodyNotify struct {
	AcquirementId     string            `json:"acquirementId"`
	MerchantTransId   string            `json:"merchantTransId"`
	FinishedTime      string            `json:"finishedTime"`
	CreatedTime       string            `json:"createdTime"`
	MerchantId        string            `json:"merchantId"`
	OrderAmount       OrderAmount       `json:"orderAmount"`
	AcquirementStatus AcquirementStatus `json:"acquirementStatus"`
}

type OrderAmount struct {
	Currency string `json:"currency"`
	Value    string `json:"value"`
}

type AcquirementStatus string

const (
	INIT           AcquirementStatus = "INIT"
	SUCCESS        AcquirementStatus = "SUCCESS"
	CLOSED         AcquirementStatus = "CLOSED"
	PAYING         AcquirementStatus = "PAYING"
	MERCHANTACCEPT AcquirementStatus = "MERCHANT_ACCEPT"
	CANCELLED      AcquirementStatus = "CANCELLED"
)
