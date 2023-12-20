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

type Dana struct {
	Logger
	Env
}

func NewDana(logger Logger, env Env) Dana {
	return Dana{
		logger,
		env,
	}
}

func (dana Dana) GetDateNow() string {
	return time.Now().Format(DanaDateFormat)
}

func (dana Dana) GenerateGUID() string {
	b := make([]byte, 16)
	_, err := rand.Read(b)
	if err != nil {
		dana.Panicf(err.Error())
	}

	b[6] = (b[6] & 0x0f) | 0x40
	b[8] = (b[8] & 0x3f) | 0x80

	return fmt.Sprintf("%x-%x-%x-%x-%x", b[0:4], b[4:6], b[6:8], b[8:10], b[10:])
}

func (dana Dana) New(url string, payloadObject map[string]interface{}) ([]byte, error) {
	jsonPayload := dana.composeRequest(payloadObject)

	client := &http.Client{}
	req, errReq := http.NewRequest("POST", dana.GetApiURL()+url, bytes.NewBuffer([]byte(jsonPayload)))
	if errReq != nil {
		return []byte{}, errReq
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Cache-control", "no-cache")
	req.Header.Set("X-DANA-SDK", "Go")
	req.Header.Set("X-DANA-SDK-VERSION", "1.0")

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

func (dana Dana) GetApiURL() string {
	if IsProduction {
		return ProductionAPIURL
	}
	return SandboxAPIURL
}

func (dana Dana) composeRequest(requestData map[string]interface{}) string {
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

func (dana Dana) GenerateSignature(data, privateKey string) string {
	block, _ := pem.Decode([]byte(privateKey))
	if block == nil {
		dana.Panic("failed to parse private key")
	}

	privy, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		dana.Panic(err)
	}

	hashed := sha256.Sum256([]byte(data))
	signature, err := rsa.SignPKCS1v15(rand.Reader, privy.(*rsa.PrivateKey), crypto.SHA256, hashed[:])
	if err != nil {
		dana.Panic(err)
	}

	return base64.StdEncoding.EncodeToString(signature)
}
