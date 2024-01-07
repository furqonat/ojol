package services

import (
	"apps/gate/db"
	"apps/gate/utils"
	"context"
)

type LugoService struct {
	db        utils.Database
	messaging *Messaging
	logger    utils.Logger
}

func NewLogoService(db utils.Database, msg *Messaging, logger utils.Logger) LugoService {
	return LugoService{
		db:        db,
		logger:    logger,
		messaging: msg,
	}
}

func (lugo LugoService) GetAvaliableService() ([]db.ServicesModel, error) {
	services, err := lugo.db.Services.FindMany(db.Services.Enable.Equals(true)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return services, err
}

func (lugo LugoService) CreateNewService(ptrServiceModel *db.ServicesModel) (*string, error) {
	service, err := lugo.db.Services.CreateOne(db.Services.ServiceType.Set(ptrServiceModel.ServiceType)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return &service.ID, nil
}

func (lugo LugoService) GetServices() ([]db.ServicesModel, error) {
	services, err := lugo.db.Services.FindMany().Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return services, nil
}

func (lugo LugoService) DeleteService(serviceId string) (*string, error) {
	service, err := lugo.db.Services.FindUnique(
		db.Services.ID.Equals(serviceId),
	).Delete().Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return &service.ID, nil
}
