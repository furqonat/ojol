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

type SearchResult struct {
	Merchant    []db.MerchantModel     `json:"merchant"`
	Customer    []db.CustomerModel     `json:"customer"`
	Driver      []db.DriverModel       `json:"driver"`
	Order       []db.OrderModel        `json:"order"`
	Transaction []db.TransactionsModel `json:"transaction"`
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

func (u LugoService) SearchAny(query string) (*SearchResult, error) {
	merchants, err := u.db.Merchant.FindMany(
		db.Merchant.Name.Contains(query),
	).With(
	  db.Merchant.MerchantWallet.Fetch(),
	  db.Merchant.Details.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	customers, err := u.db.Customer.FindMany(
		db.Customer.Name.Contains(query),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	drivers, err := u.db.Driver.FindMany(
		db.Driver.Name.Contains(query),
	).With(
	  db.Driver.DriverDetails.Fetch().With(
	    db.DriverDetails.Vehicle.Fetch(),
	  ),
	  db.Driver.DriverWallet.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	orders, err := u.db.Order.FindMany(
		db.Order.ID.Contains(query),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	transactions, err := u.db.Transactions.FindMany(
		db.Transactions.ID.Contains(query),
	).With(
	  db.Transactions.Order.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return &SearchResult{
		Merchant:    merchants,
		Customer:    customers,
		Driver:      drivers,
		Order:       orders,
		Transaction: transactions,
	}, nil

}
