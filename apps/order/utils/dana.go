package utils

import (
	"bytes"
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/json"
	"encoding/pem"
	"errors"
	"fmt"
	"io"
	"net/http"
	"time"
)

type DanaApi struct {
	Logger
	Env
}

func NewDanaApi(logger Logger, env Env) DanaApi {
	return DanaApi{
		logger,
		env,
	}
}

func (dana DanaApi) GetDateNow() string {
	return time.Now().Format(DanaDateFormat)
}

func (dana DanaApi) GenerateGUID() string {
	b := make([]byte, 16)
	_, err := rand.Read(b)
	if err != nil {
		dana.Panicf(err.Error())
	}

	b[6] = (b[6] & 0x0f) | 0x40
	b[8] = (b[8] & 0x3f) | 0x80

	return fmt.Sprintf("%x-%x-%x-%x-%x", b[0:4], b[4:6], b[6:8], b[8:10], b[10:])
}

func (dana DanaApi) New(url string, payloadObject map[string]interface{}) ([]byte, error) {
	jsonPayload := dana.composeRequest(payloadObject)

	client := &http.Client{}
	req, err := http.NewRequest("POST", dana.GetApiURL()+url, bytes.NewBuffer([]byte(jsonPayload)))
	if err != nil {
		return []byte{}, err
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Cache-control", "no-cache")
	req.Header.Set("X-DANA-SDK", "Go")
	req.Header.Set("X-DANA-SDK-VERSION", "1.0")

	resp, err := client.Do(req)
	if err != nil {
		errMsg := fmt.Sprintf("Error : %s %s", dana.GetApiURL(), url)
		return []byte{}, errors.New(errMsg)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return []byte{}, err
	}

	return body, nil
}

func (dana DanaApi) SnapApplyToken(url string, payloadObject map[string]interface{}) ([]byte, error) {
	payload := dana.composeSnapRequest(payloadObject)
	client := &http.Client{}
	req, errReq := http.NewRequest("POST", dana.GetApiURL()+url, bytes.NewBuffer([]byte(payload)))
	if errReq != nil {
		return []byte{}, errReq
	}
	now := dana.GetDateNow()
	encodedString := ClientID + "|" + now
	signature := dana.GenerateSignature(encodedString, PrivateKey)

	// dana.Logger.Info("Signature : %s", signature)

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("X-TIMESTAMP", now)
	req.Header.Set("X-SIGNATURE", signature)
	req.Header.Set("X-CLIENT-KEY", ClientID)
	req.Header.Set("CHANNEL-ID", dana.GenerateGUID())

	resp, errClient := client.Do(req)
	if errClient != nil {
		errMsg := fmt.Sprintf("Error : %s %s", dana.GetApiURL(), url)
		return []byte{}, errors.New(errMsg)
	}

	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			dana.Panicf("Unuxpected error: %s", err.Error())
		}
	}(resp.Body)

	body, errIO := io.ReadAll(resp.Body)
	if errIO != nil {
		return []byte{}, errIO
	}

	return body, nil
}

func (dana DanaApi) SnapTransaction(url string, payloadObject map[string]interface{}, accessToken string, b2bAccessToken string) ([]byte, error) {
	payload := dana.composeSnapRequest(payloadObject)
	client := &http.Client{}

	req, errReq := http.NewRequest("POST", dana.GetApiURL()+url, bytes.NewBuffer([]byte(payload)))
	if errReq != nil {
		return []byte{}, errReq
	}
	hash := sha256.New()
	hash.Write([]byte(payload))
	hashedBody := fmt.Sprintf("%x", hash.Sum(nil))
	now := dana.GetDateNow()
	encodedString := fmt.Sprintf("POST:%s:%s:%s", url, hashedBody, now)
	signature := dana.GenerateSignature(encodedString, PrivateKey)

	req.Header.Set("X-TIMESTAMP", now)
	req.Header.Set("X-SIGNATURE", signature)
	req.Header.Set("X-PARTNER-ID", ClientID)
	req.Header.Set("X-EXTERNAL-ID", dana.GenerateGUID())
	req.Header.Set("X-DEVICE-ID", "android-"+dana.GenerateGUID())
	req.Header.Set("CHANNEL-ID", dana.GenerateGUID())
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("X-DANA-SDK", "Go")
	req.Header.Set("X-DANA-SDK-VERSION", "1.0")
	req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", b2bAccessToken))

	resp, errClient := client.Do(req)
	if errClient != nil {
		errMsg := fmt.Sprintf("Error : %s %s", dana.GetApiURL(), url)
		return []byte{}, errors.New(errMsg)
	}

	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			dana.Panicf("Unuxpected error: %s", err.Error())
		}
	}(resp.Body)

	body, errIO := io.ReadAll(resp.Body)
	if errIO != nil {
		return []byte{}, errIO
	}

	return body, nil
}

func (dana DanaApi) GetApiURL() string {
	if IsProduction {
		return ProductionAPIURL
	}
	return SandboxAPIURL
}

func (dana DanaApi) composeRequest(requestData map[string]interface{}) string {
	requestDataText, err := json.Marshal(requestData)
	if err != nil {
		dana.Panic(err)
	}

	requestDataText = bytes.ReplaceAll(requestDataText, []byte("\\\""), []byte("\""))
	signature := dana.GenerateSignature(string(requestDataText), PrivateKey)
	requestPayload := map[string]interface{}{
		"request":   requestData,
		"signature": signature,
	}

	requestPayloadText, err := json.Marshal(requestPayload)
	if err != nil {
		dana.Panic(err)
	}

	return string(bytes.ReplaceAll(requestPayloadText, []byte("\\\""), []byte("\"")))
}

func (dana DanaApi) composeSnapRequest(requestData map[string]interface{}) string {
	requestDataText, err := json.Marshal(requestData)
	if err != nil {
		dana.Panic(err)
	}
	return string(bytes.ReplaceAll(requestDataText, []byte("\\\""), []byte("\"")))
}

func (dana DanaApi) GenerateSignature(data, privateKey string) string {
	block, _ := pem.Decode([]byte(privateKey))
	if block == nil {
		dana.Panic("failed to parse private key")
	}

	priv, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		dana.Panic(err)
	}

	hashed := sha256.Sum256([]byte(data))
	signature, err := rsa.SignPKCS1v15(rand.Reader, priv.(*rsa.PrivateKey), crypto.SHA256, hashed[:])
	if err != nil {
		dana.Panic(err)
	}

	return base64.StdEncoding.EncodeToString(signature)
}

func (dana DanaApi) IsResponseSuccess(response map[string]interface{}) (map[string]interface{}, bool) {
	if response == nil {
		return nil, false
	}

	body, exists := response["response"].(map[string]interface{})["body"].(map[string]interface{})
	if !exists {
		return nil, false
	}

	resultInfo, exists := body["resultInfo"].(map[string]interface{})
	if !exists {
		return nil, false
	}

	resultCode, exists := resultInfo["resultCode"].(string)
	if !exists {
		return nil, false
	}

	return resultInfo, resultCode == "SUCCESS"
}
