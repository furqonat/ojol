package utils

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

const production = false

type DanaApi struct {
	logger Logger
	env    Env
}

func NewDanaApi(logger Logger, env Env) DanaApi {
	return DanaApi{
		logger: logger,
		env:    env,
	}
}

func (dana DanaApi) GetWebUrl() string {
	if production {
		return dana.env.PRODUCTION_URL
	} else {
		return dana.env.SANBOX_URL
	}
}

func (dana DanaApi) Post(path string, body map[string]interface{}) any {
	link := fmt.Sprintf("%s%s", dana.GetWebUrl(), path)
	postBody, errBody := json.Marshal(body)
	if errBody != nil {
		dana.logger.Panicf(errBody.Error())
	}

	requestBody := bytes.NewBuffer(postBody)

	resp, errReq := http.Post(link, "application/json", requestBody)
	if errReq != nil {
		dana.logger.Panicf(errReq.Error())
	}
	return json.NewDecoder(resp.Body)
}

func (dana DanaApi) Get(path string) {

}
