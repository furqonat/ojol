package services

import (
	"apps/transactions/db"
	"context"
)

func (trx TrxService) GetDriverTrxInDay(driverId string) ([]db.DriverTrxModel, error) {
	previousDay := trx.getPreviousDay()
	nextDay := trx.getNextDay()

	db, err := trx.database.DriverTrx.FindMany(
		db.DriverTrx.CreatedAt.Lte(nextDay),
		db.DriverTrx.CreatedAt.Gte(previousDay),
		db.DriverTrx.DriverID.Equals(driverId),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return db, nil
}

func (trx TrxService) GetDriverTrxInWeek(driverId string) ([]db.DriverTrxModel, error) {
	previousDay := trx.getPreviousWeek()
	nextDay := trx.getNextWeek()

	db, err := trx.database.DriverTrx.FindMany(
		db.DriverTrx.CreatedAt.Lte(nextDay),
		db.DriverTrx.CreatedAt.Gte(previousDay),
		db.DriverTrx.DriverID.Equals(driverId),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return db, nil
}

func (trx TrxService) GetDriverTrxInMonth(driverId string) ([]db.DriverTrxModel, error) {
	previousDay := trx.getPreviousMonth()
	nextDay := trx.getNextMonth()

	db, err := trx.database.DriverTrx.FindMany(
		db.DriverTrx.CreatedAt.Lte(nextDay),
		db.DriverTrx.CreatedAt.Gte(previousDay),
		db.DriverTrx.DriverID.Equals(driverId),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return db, nil
}
