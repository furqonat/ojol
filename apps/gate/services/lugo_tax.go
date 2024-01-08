package services

import (
	"apps/gate/db"
	"context"
)

func (u LugoService) CreateTax(appliedFor db.AppliedFor, taxType db.TaxType, amount int) (*string, error) {
	tax, errTax := u.db.Tax.CreateOne(
		db.Tax.AppliedFor.Set(appliedFor),
		db.Tax.TaxType.Set(taxType),
		db.Tax.Amount.Set(amount),
	).Exec(context.Background())

	if errTax != nil {
		return nil, errTax
	}
	return &tax.ID, nil
}

func (u LugoService) GetTax() ([]db.TaxModel, error) {
	tax, err := u.db.Tax.FindMany().Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return tax, nil
}

func (u LugoService) UpdateTax(taxId string, data *db.TaxModel) (*string, error) {
	tax, errTax := u.db.Tax.FindUnique(
		db.Tax.ID.Equals(taxId),
	).Update(
		db.Tax.Amount.SetIfPresent(&data.Amount),
	).Exec(context.Background())

	if errTax != nil {
		return nil, errTax
	}

	return &tax.ID, nil
}

func (u LugoService) DeleteTax(taxId string) error {
	if _, err := u.db.Tax.FindUnique(
		db.Tax.ID.Equals(taxId),
	).Delete().Exec(context.Background()); err != nil {
		return err
	}
	return nil
}
