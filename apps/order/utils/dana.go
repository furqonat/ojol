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
	req, err := http.NewRequest("POST", dana.GetAPIURL()+url, bytes.NewBuffer([]byte(jsonPayload)))
	if err != nil {
		return []byte{}, err
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Cache-control", "no-cache")
	req.Header.Set("X-DANA-SDK", "Go")
	req.Header.Set("X-DANA-SDK-VERSION", "1.0")

	resp, err := client.Do(req)
	if err != nil {
		errMsg := fmt.Sprintf("Error : %s %s", dana.GetAPIURL(), url)
		return []byte{}, errors.New(errMsg)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return []byte{}, err
	}

	return body, nil
}

func (dana DanaApi) GetAPIURL() string {
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
