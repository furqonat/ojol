package services

import (
	"apps/gate/db"
	"context"
	"math"
)

func (lugo LugoService) GetTrxFee() ([]db.ServiceFeeModel, error) {
	fee, errFee := lugo.db.ServiceFee.FindMany().Exec(context.Background())
	if errFee != nil {
		return nil, errFee
	}
	return fee, nil
}

func (lugo LugoService) CreateTrxFee(service *db.ServiceFeeModel) (*string, error) {
	fee, errFee := lugo.db.ServiceFee.CreateOne(
		db.ServiceFee.ServiceType.Set(service.ServiceType),
		db.ServiceFee.Percentage.Set(service.Percentage),
		db.ServiceFee.AccountType.Set(service.AccountType),
	).Exec(context.Background())
	if errFee != nil {
		return nil, errFee
	}
	return &fee.ID, nil
}

func (lugo LugoService) DeleteFee(feeId string) error {
	_, errFee := lugo.db.ServiceFee.FindUnique(
		db.ServiceFee.ID.Equals(feeId),
	).Delete().Exec(context.Background())

	if errFee != nil {
		return errFee
	}
	return nil
}

func (lugo LugoService) PriceInKM(distance float64, serviceType db.ServiceType) (*int, error) {
	price, errPrice := lugo.db.Services.FindFirst(
		db.Services.ServiceType.Equals(serviceType),
	).Exec(context.Background())
	if errPrice != nil {
		return nil, errPrice
	}
	absDistance := int(math.Ceil(distance))
	if absDistance < price.MinKm && price.MinKm != 0 {
		return &price.PriceInMinKm, nil
	}
	mDist := math.Ceil(float64(absDistance) - float64(price.MinKm))
	value := (price.PriceInKm * int(mDist)) + price.PriceInMinKm

	return &value, nil
}

func (lugo LugoService) UpdateTrxFee(feeId string, model *db.ServiceFeeModel) (*string, error) {
	fee, err := lugo.db.ServiceFee.FindUnique(
		db.ServiceFee.ID.Equals(feeId),
	).Update(
		db.ServiceFee.AccountType.Set(model.AccountType),
		db.ServiceFee.ServiceType.Set(model.ServiceType),
		db.ServiceFee.Percentage.Set(model.Percentage),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return &fee.ID, nil
}

func (lugo LugoService) UpdateService(serviceId string, ptrServiceModel *db.ServicesModel) (*string, error) {
	service, err := lugo.db.Services.FindUnique(
		db.Services.ID.Equals(serviceId),
	).Update(
		db.Services.Enable.SetIfPresent(&ptrServiceModel.Enable),
		db.Services.ServiceType.SetIfPresent(&ptrServiceModel.ServiceType),
		db.Services.PriceInKm.SetIfPresent(&ptrServiceModel.PriceInKm),
		db.Services.MinKm.SetIfPresent(&ptrServiceModel.MinKm),
		db.Services.PriceInMinKm.SetIfPresent(&ptrServiceModel.PriceInMinKm),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return &service.ID, nil
}
