package utils

import (
	"github.com/spf13/viper"
)

// Env has environment stored
type Env struct {
	ServerPort     string `mapstructure:"SERVER_PORT"`
	Environment    string `mapstructure:"ENV"`
	SANBOX_URL     string `mapstructure:"SANBOX_URL"`
	PRODUCTION_URL string `mapstructure:"PRODUCTION_URL"`
	MERCHANT_ID    string `mapstructure:"MERCHANT_ID"`
	CLIENT_ID      string `mapstructure:"CLIENT_ID"`
	CLIENT_SECRET  string `mapstructure:"CLIENT_SECRET"`
	PUBLIC_KEY     string `mapstructure:"PUBLIC_KEY"`
	SECRET_KEY     string `mapstructure:"SECRET_KEY"`
}

// NewEnv creates a new environment
func NewEnv(log Logger) Env {

	env := Env{}
	viper.SetConfigFile(".env")
	viper.SetConfigType("env")
	viper.AutomaticEnv()

	err := viper.ReadInConfig()
	if err != nil {
		log.Fatal("☠️ cannot read configuration")
	}

	err = viper.Unmarshal(&env)
	if err != nil {
		log.Fatal("☠️ environment can't be loaded: ", err)
	}

	log.Infof("%+v \n", env)
	return env
}
