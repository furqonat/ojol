package services

import (
	"apps/transactions/db"
	"context"
)

func (trx TrxService) GetTrxInDay(merchantId string) ([]db.MerchantTrxModel, error) {
	previousDay := trx.getPreviousDay()
	nextDay := trx.getNextDay()

	db, err := trx.database.MerchantTrx.FindMany(
		db.MerchantTrx.CreatedAt.Lte(nextDay),
		db.MerchantTrx.CreatedAt.Gte(previousDay),
		db.MerchantTrx.MerchantID.Equals(merchantId),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return db, nil
}

func (trx TrxService) GetTrxInWeek(merchantId string) ([]db.MerchantTrxModel, error) {
	previousDay := trx.getPreviousWeek()
	nextDay := trx.getNextWeek()

	db, err := trx.database.MerchantTrx.FindMany(
		db.MerchantTrx.CreatedAt.Lte(nextDay),
		db.MerchantTrx.CreatedAt.Gte(previousDay),
		db.MerchantTrx.MerchantID.Equals(merchantId),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return db, nil
}

func (trx TrxService) GetTrxInMonth(merchantId string) ([]db.MerchantTrxModel, error) {
	previousDay := trx.getPreviousMonth()
	nextDay := trx.getNextMonth()

	db, err := trx.database.MerchantTrx.FindMany(
		db.MerchantTrx.CreatedAt.Lte(nextDay),
		db.MerchantTrx.CreatedAt.Gte(previousDay),
		db.MerchantTrx.MerchantID.Equals(merchantId),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return db, nil
}
