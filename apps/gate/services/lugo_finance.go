package services

import (
	"apps/gate/db"
	"apps/gate/utils"
	"context"
	"time"
)

func (u LugoService) DriverTopUp(driverId string, model *db.DriverTrxModel) error {
	// driver, errD := u.db.Driver.FindUnique(
	// 	db.Driver.ID.Equals(driverId),
	// ).With(
	// ).Exec(context.Background())
	// s, err := u.db.DriverTrx.CreateOne(
	// 	db.DriverTrx.TrxType.Set(model.TrxType),
	// 	db.DriverTrx.Driver.Link(db.Driver.ID.Equals(driverId)),
	// 	db.DriverTrx.Amount.Set(model.Amount),
	// ).Exec(context.Background())
	// if err != nil {
	// 	return err
	// }

	return nil
}

func (u LugoService) MerchantTopUp() {

}

func (u LugoService) GetCompanyBallance() (*utils.MerchantQuery, error) {
	resp, err := u.dana.GetCompanyBallance()
	if err != nil {
		return nil, err
	}
	return resp, nil
}

func (u LugoService) CreateDiscount(model *db.DiscountModel) (*string, error) {
	result, err := u.db.Discount.CreateOne(
		db.Discount.Code.Set(model.Code),
		db.Discount.MaxDiscount.Set(model.MaxDiscount),
		db.Discount.Amount.Set(model.Amount),
		db.Discount.TrxType.Set(model.TrxType),
		db.Discount.MinTransaction.Set(model.MinTransaction),
		db.Discount.ExpiredAt.SetIfPresent(u.assignPtrTimeIfTrue(model.ExpiredAt())),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return &result.ID, nil
}

func (u LugoService) assignPtrTimeIfTrue(value time.Time, condition bool) *time.Time {
	if condition {
		return &value
	}
	return nil
}

func (u LugoService) GetDiscount() ([]db.DiscountModel, error) {
	result, err := u.db.Discount.FindMany(db.Discount.ExpiredAt.Gte(time.Now())).OrderBy(db.Discount.ExpiredAt.Order(db.DESC)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return result, nil
}

func (u LugoService) DeleteDiscount(discountId string) error {
	if _, err := u.db.Discount.FindUnique(
		db.Discount.ID.Equals(discountId),
	).Delete().Exec(context.Background()); err != nil {
		return err
	}
	return nil
}
