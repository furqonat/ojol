package services

import (
	"apps/order/db"
	"context"
)

func (order OrderService) createTrxCompnay(trxType db.TrxType, trxFrom db.TrxCompanyType, amount int) error {
	_, err := order.database.TrxCompany.CreateOne(
		db.TrxCompany.TrxType.Set(trxType),
		db.TrxCompany.TrxFrom.Set(trxFrom),
		db.TrxCompany.Amount.Set(amount),
	).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) driverBonus(serviceType db.ServiceType, orderId string, driverId string, amount int) error {
	_, err := order.database.BonusDriver.CreateOne(
		db.BonusDriver.TrxType.Set(serviceType),
		db.BonusDriver.Amount.Set(amount),
		db.BonusDriver.Order.Link(db.Order.ID.Equals(orderId)),
		db.BonusDriver.Drivers.Link(db.Driver.ID.Equals(driverId)),
	).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}
