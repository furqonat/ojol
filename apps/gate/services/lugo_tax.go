package services

import (
	"apps/gate/db"
	"context"
)

func (lugo LugoService) CreateTax(appliedFor db.AppliedFor, taxType db.TaxType, amount int) (*string, error) {
	tax, errTax := lugo.db.Tax.CreateOne(
		db.Tax.AppliedFor.Set(appliedFor),
		db.Tax.TaxType.Set(taxType),
		db.Tax.Amount.Set(amount),
	).Exec(context.Background())

	if errTax != nil {
		return nil, errTax
	}
	return &tax.ID, nil
}

func (lugo LugoService) UpdateTax(taxId string, data *db.TaxModel) (*string, error) {
	tax, errTax := lugo.db.Tax.FindUnique(
		db.Tax.ID.Equals(taxId),
	).Update(
		db.Tax.Amount.SetIfPresent(&data.Amount),
	).Exec(context.Background())

	if errTax != nil {
		return nil, errTax
	}

	return &tax.ID, nil
}
