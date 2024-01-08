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
	dana      DanaService
}

func NewLogoService(db utils.Database, msg *Messaging, logger utils.Logger, dana DanaService) LugoService {
	return LugoService{
		db:        db,
		logger:    logger,
		messaging: msg,
		dana:      dana,
	}
}

func (u LugoService) GetAvailableService() ([]db.ServicesModel, error) {
	services, err := u.db.Services.FindMany(db.Services.Enable.Equals(true)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return services, err
}

func (u LugoService) CreateNewService(ptrServiceModel *db.ServicesModel) (*string, error) {
	service, err := u.db.Services.CreateOne(db.Services.ServiceType.Set(ptrServiceModel.ServiceType)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return &service.ID, nil
}

func (u LugoService) GetServices() ([]db.ServicesModel, error) {
	services, err := u.db.Services.FindMany().Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return services, nil
}

func (u LugoService) DeleteService(serviceId string) (*string, error) {
	service, err := u.db.Services.FindUnique(
		db.Services.ID.Equals(serviceId),
	).Delete().Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return &service.ID, nil
}
