package utils

import (
	"github.com/spf13/viper"
)

// Env has environment stored
type Env struct {
	ServerPort                 string `mapstructure:"SERVER_PORT"`
	Environment                string `mapstructure:"ENV"`
	PrivateKey                 string `mapstructure:"PRIVATE_KEY"`
	ProdAPIURL                 string `mapstructure:"PROD_API_URL"`
	DevAPIURL                  string `mapstructure:"DEV_API_URL"`
	ClientID                   string `mapstructure:"CLIENT_ID"`
	ClientSecret               string `mapstructure:"CLIENT_SECRET"`
	MerchantID                 string `mapstructure:"MERCHANT_ID"`
	MerchantMCC                string `mapstructure:"MERCHANT_MCC"`
	AcquirementPayReturnURL    string `mapstructure:"PAY_RETURN_URL"`
	AcquirementNotificationURL string `mapstructure:"NOTIFICATION_URL"`
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
