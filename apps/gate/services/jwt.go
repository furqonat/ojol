package services

import (
	"apps/gate/utils"
	"errors"
	"fmt"

	"github.com/golang-jwt/jwt/v5"
	"github.com/mitchellh/mapstructure"
)

type Role struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

type Claims struct {
	ID   string `json:"id"`
	Name string `json:"name"`
	Role []Role `json:"role"`
}

type JWTService struct {
	logger utils.Logger
}

func NewJWTService(logger utils.Logger) JWTService {
	return JWTService{
		logger: logger,
	}
}

func (service JWTService) Decode(jwtString string) (*Claims, error) {

	token, err := jwt.Parse(jwtString, func(t *jwt.Token) (interface{}, error) {
		_, ok := t.Method.(*jwt.SigningMethodHMAC)

		if !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", t.Header["alg"])
		}

		return []byte("auth-secret-1234"), nil
	})
	if err != nil {
		return nil, err
	}
	claims, ok := token.Claims.(jwt.MapClaims)

	if !ok {
		return nil, errors.New("unable get claims")
	}

	c := Claims{}
	err = mapstructure.Decode(claims, &c)
	if err != nil {
		return nil, err
	}

	return &c, nil
}
