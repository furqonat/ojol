package services

import (
	"apps/gate/db"
	"context"
	"math"
)

func (u LugoService) GetTrxFee() ([]db.ServiceFeeModel, error) {
	fee, errFee := u.db.ServiceFee.FindMany().Exec(context.Background())
	if errFee != nil {
		return nil, errFee
	}
	return fee, nil
}

func (u LugoService) CreateTrxFee(service *db.ServiceFeeModel) (*string, error) {
	fee, errFee := u.db.ServiceFee.CreateOne(
		db.ServiceFee.ServiceType.Set(service.ServiceType),
		db.ServiceFee.Percentage.Set(service.Percentage),
		db.ServiceFee.AccountType.Set(service.AccountType),
	).Exec(context.Background())
	if errFee != nil {
		return nil, errFee
	}
	return &fee.ID, nil
}

func (u LugoService) DeleteFee(feeId string) error {
	_, errFee := u.db.ServiceFee.FindUnique(
		db.ServiceFee.ID.Equals(feeId),
	).Delete().Exec(context.Background())

	if errFee != nil {
		return errFee
	}
	return nil
}

func (u LugoService) PriceInKM(distance float64, serviceType db.ServiceType) (*int, error) {
	price, errPrice := u.db.Services.FindFirst(
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

func (u LugoService) UpdateTrxFee(feeId string, model *db.ServiceFeeModel) (*string, error) {
	fee, err := u.db.ServiceFee.FindUnique(
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

func (u LugoService) UpdateService(serviceId string, ptrServiceModel *db.ServicesModel) (*string, error) {
	service, err := u.db.Services.FindUnique(
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

func (u LugoService) CreateKorlapFee(data *db.KorlapFeeModel) (*db.KorlapFeeModel, error) {

	fee, err := u.db.KorlapFee.CreateOne(
		db.KorlapFee.AdminType.Set(data.AdminType),
		db.KorlapFee.Percentage.Set(data.Percentage),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return fee, nil
}

func (u LugoService) UpdateKorlapFee(id string, data *db.KorlapFeeModel) (*string, error) {
	fee, err := u.db.KorlapFee.FindUnique(
		db.KorlapFee.ID.Equals(id),
	).Update(
		db.KorlapFee.Percentage.Set(data.Percentage),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return &fee.ID, nil
}

func (u LugoService) DeleteKorlapFee(id string) error {
	_, err := u.db.KorlapFee.FindUnique(
		db.KorlapFee.ID.Equals(id),
	).Delete().Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (u LugoService) GetKorlapFee(take, skip int) ([]db.KorlapFeeModel, int, error) {
	fees, err := u.db.KorlapFee.FindMany().Take(take).Skip(skip).Exec(context.Background())
	if err != nil {
		return nil, 0, err
	}
	total, errT := u.db.KorlapFee.FindMany().Exec(context.Background())
	if errT != nil {
		return nil, 0, err
	}
	return fees, len(total), nil
}
