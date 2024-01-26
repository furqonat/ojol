package services

import (
	"apps/gate/db"
	"apps/gate/utils"
	"context"
	"errors"
	"fmt"
	"regexp"
	"strings"
	"time"
)

type CompantTrx struct {
	Balance          int `json:"balance"`
	BalanceBeforeFee int `json:"balance_before_fee"`
	BonusDriver      int `json:"bonus_driver"`
	NetProfit        int `json:"net_profit"`
}

func (u LugoService) DriverTopUp(driverId string, amount int) (*utils.CreateOrder, error) {
	trx, _ := u.db.DriverTrx.FindFirst(
		db.DriverTrx.DriverID.Equals(driverId),
		db.DriverTrx.Status.Equals(db.TrxStatusProcess),
		db.DriverTrx.TrxType.Equals(db.TrxTypeTopup),
	).Exec(context.Background())
	if trx != nil {
		checkoutUrl, ok := trx.CheckoutURL()
		if !ok {
			return nil, errors.New("unable fetch check url")
		}
		return &utils.CreateOrder{
			CheckoutUrl: checkoutUrl,
		}, nil
	}
	mTrx, errMerchTrx := u.db.DriverTrx.CreateOne(
		db.DriverTrx.TrxType.Set(db.TrxTypeTopup),
		db.DriverTrx.Driver.Link(db.Driver.ID.Equals(driverId)),
		db.DriverTrx.Amount.Set(amount),
		db.DriverTrx.Status.Set(db.TrxStatusProcess),
	).Exec(context.Background())
	currentTime := time.Now()

	if errMerchTrx != nil {
		return nil, errMerchTrx
	}

	// Add 1 hour to the current time
	oneHourLater := currentTime.Add(time.Hour)

	formattedTime := oneHourLater.Format(utils.DanaDateFormat)
	dana, errDana := u.dana.CreateNewOrder(
		formattedTime,
		"transactionType",
		"TOPUP",
		fmt.Sprintf("TPD-%s", mTrx.ID),
		amount*100,
		"riskObjectId",
		"riskObjectCode",
		"riskObjectOperator",
		"",
	)
	if errDana != nil {
		return nil, errDana
	}
	_, err := u.db.DriverTrx.FindUnique(
		db.DriverTrx.ID.Equals(mTrx.ID),
	).Update(
		db.DriverTrx.CheckoutURL.Set(dana.CheckoutUrl),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return dana, nil
}

func (u LugoService) MerchantTopUp(merchantId string, amount int) (*utils.CreateOrder, error) {
	trx, _ := u.db.MerchantTrx.FindFirst(
		db.MerchantTrx.MerchantID.Equals(merchantId),
		db.MerchantTrx.Status.Equals(db.TrxStatusProcess),
		db.MerchantTrx.TrxType.Equals(db.TrxTypeTopup),
	).Exec(context.Background())
	// if errTrx == nil {
	// 	return nil, errTrx
	// }

	if trx != nil {
		checkoutUrl, ok := trx.CheckoutURL()
		if !ok {
			return nil, errors.New("unable fetch check url")
		}
		return &utils.CreateOrder{
			CheckoutUrl: checkoutUrl,
		}, nil
	}
	mTrx, errMerchTrx := u.db.MerchantTrx.CreateOne(
		db.MerchantTrx.TrxType.Set(db.TrxTypeTopup),
		db.MerchantTrx.Merchant.Link(db.Merchant.ID.Equals(merchantId)),
		db.MerchantTrx.Amount.Set(amount),
		db.MerchantTrx.Status.Set(db.TrxStatusProcess),
	).Exec(context.Background())
	currentTime := time.Now()

	if errMerchTrx != nil {
		return nil, errMerchTrx
	}

	// Add 1 hour to the current time
	oneHourLater := currentTime.Add(time.Hour)

	formattedTime := oneHourLater.Format(utils.DanaDateFormat)
	dana, errDana := u.dana.CreateNewOrder(
		formattedTime,
		"transactionType",
		"TOPUP",
		fmt.Sprintf("TPM-%s", mTrx.ID),
		amount*100,
		"riskObjectId",
		"riskObjectCode",
		"riskObjectOperator",
		"",
	)
	if errDana != nil {
		return nil, errDana
	}
	_, err := u.db.MerchantTrx.FindUnique(
		db.MerchantTrx.ID.Equals(mTrx.ID),
	).Update(
		db.MerchantTrx.CheckoutURL.Set(dana.CheckoutUrl),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return dana, nil
}

func (u LugoService) GetCompanyBallance() (*utils.MerchantQuery, error) {
	resp, err := u.dana.GetCompanyBallance()
	if err != nil {
		return nil, err
	}
	return resp, nil
}

func (u LugoService) GetCompanyBalanceTrx(trxIn string) ([]db.TrxCompanyModel, error) {

	if trxIn == "day" {
		return u.GetCompanyBallanceInDay()
	}

	if trxIn == "week" {
		return u.GetCompanyBallanceInWeek()
	}

	return u.GetCompanyBallanceInMonth()
}

func (u LugoService) GetCompanyBallanceInDay() ([]db.TrxCompanyModel, error) {
	data, err := u.db.TrxCompany.FindMany(
		db.TrxCompany.CreatedAt.Lte(u.getNextDay()),
		db.TrxCompany.CreatedAt.Gte(u.getPreviousDay()),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}

	return data, nil
}

func (u LugoService) GetCompanyBallanceInWeek() ([]db.TrxCompanyModel, error) {
	data, err := u.db.TrxCompany.FindMany(
		db.TrxCompany.CreatedAt.Lte(u.getNextWeek()),
		db.TrxCompany.CreatedAt.Gte(u.getPreviousWeek()),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return data, nil
}

func (u LugoService) GetCompanyBallanceInMonth() ([]db.TrxCompanyModel, error) {
	data, err := u.db.TrxCompany.FindMany(
		db.TrxCompany.CreatedAt.Lte(u.getNextMonth()),
		db.TrxCompany.CreatedAt.Gte(u.getPreviousMonth()),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return data, nil
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

// func (u LugoService) GetBonusDrivers() ([]db.DriverModel, error) {
// 	result, err := u.db.Driver.FindMany(
// 		db.Driver.Name.Order(db.ASC),
// 	).With(
// 		db.Driver.BonusDriver.Fetch().With(
// 			db.BonusDriver.Order.Fetch().With(
// 				db.Order.OrderDetail.Fetch(),
// 				db.Order.OrderItems.Fetch().With(
// 					db.OrderItem.Product.Fetch(),
// 				),
// 			),
// 		),
// 		db.Driver.DriverDetails.Fetch(),
// 		db.Driver.DriverWallet.Fetch(),
// 		// db.Driver.DanaToken.Fetch(),
// 	).Exec(context.Background())
// 	if err != nil {
// 		return nil, err
// 	}
// 	return result, nil
// }

// func (u LugoService) GetBonusDriver(driverId string) ([]db.DriverModel, error) {
// 	result, err := u.db.Driver.FindMany(
// 		db.Driver.ID.Equals(driverId),
// 	).With(
// 		db.Driver.BonusDriver.Fetch().With(
// 			db.BonusDriver.Order.Fetch().With(
// 				db.Order.OrderDetail.Fetch(),
// 				db.Order.OrderItems.Fetch().With(
// 					db.OrderItem.Product.Fetch(),
// 				),
// 			),
// 		),
// 		db.Driver.DriverDetails.Fetch(),
// 		db.Driver.DriverWallet.Fetch(),
// 		db.Driver.DanaToken.Fetch(),
// 	).Exec(context.Background())
// 	if err != nil {
// 		return nil, err
// 	}
// 	return result, nil
// }

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

func (u LugoService) AdminRequestWithdraw(adminId string, amount int) (*utils.WithdrawRequest, error) {
	admin, errAdmin := u.db.Admin.FindUnique(
		db.Admin.ID.Equals(adminId),
	).With(
		db.Admin.AdminWallet.Fetch(),
	).Exec(context.Background())
	if errAdmin != nil {
		return nil, errAdmin
	}
	adminWallet, okAdminWalet := admin.AdminWallet()
	if !okAdminWalet {
		return nil, errors.New("unable fetch admin wallet")
	}
	if adminWallet.Balance < amount {
		return nil, errors.New("balance is not enough")
	}
	mWallet, errUpdateWallet := u.db.AdminWallet.FindUnique(
		db.AdminWallet.AdminID.Equals(adminId),
	).Update(
		db.AdminWallet.Balance.Decrement(amount),
	).Exec(context.Background())
	if errUpdateWallet != nil {
		return nil, errUpdateWallet
	}
	mTrx, errCreateAdminTrx := u.db.TrxAdmin.CreateOne(
		db.TrxAdmin.TrxType.Set(db.TrxTypeReduction),
		db.TrxAdmin.Amount.Set(amount),
		db.TrxAdmin.Admin.Link(db.Admin.ID.Equals(adminId)),
	).Exec(context.Background())
	if errCreateAdminTrx != nil {
		_, errDel := u.db.AdminWallet.FindUnique(
			db.AdminWallet.ID.Equals(mWallet.ID),
		).Update(
			db.AdminWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.TrxAdmin.FindUnique(
			db.TrxAdmin.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, errCreateAdminTrx
	}
	phone, okPhone := admin.PhoneNumber()
	if !okPhone {
		_, errDel := u.db.AdminWallet.FindUnique(
			db.AdminWallet.ID.Equals(mWallet.ID),
		).Update(
			db.AdminWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.TrxAdmin.FindUnique(
			db.TrxAdmin.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, errors.New("unable fetch admin phone number")
	}
	result, err := u.dana.RequestWithdraw(u.sanitizePhone(phone), amount*100, mTrx.ID)
	if err != nil {
		_, errDel := u.db.AdminWallet.FindUnique(
			db.AdminWallet.ID.Equals(mWallet.ID),
		).Update(
			db.AdminWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.TrxAdmin.FindUnique(
			db.TrxAdmin.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		u.logger.Info(u.formatPhoneNumber(u.sanitizePhone(phone)))
		return nil, err
	}
	if err := u.createTrxCompnay(db.TrxTypeReduction, db.TrxCompanyTypeAdmin, amount); err != nil {
		return nil, err
	}
	return result, nil
}

func (u LugoService) MerchantRequestWithdraw(merchantId string, amount int) (*utils.WithdrawRequest, error) {
	merchant, errMerchant := u.db.Merchant.FindUnique(
		db.Merchant.ID.Equals(merchantId),
	).With(
		db.Merchant.MerchantWallet.Fetch(),
	).Exec(context.Background())
	if errMerchant != nil {
		return nil, errMerchant
	}
	wallet, ok := merchant.MerchantWallet()
	if !ok {
		return nil, errors.New("unable fetch merchant wallet")
	}
	if wallet.Balance < amount {
		return nil, errors.New("balance is not enough")
	}
	mWallet, errUpdate := u.db.MerchantWallet.FindUnique(
		db.MerchantWallet.ID.Equals(wallet.ID),
	).Update(
		db.MerchantWallet.Balance.Decrement(amount),
	).Exec(context.Background())

	if errUpdate != nil {
		return nil, errUpdate
	}
	mTrx, errMerchTrx := u.db.MerchantTrx.CreateOne(
		db.MerchantTrx.TrxType.Set(db.TrxTypeReduction),
		db.MerchantTrx.Merchant.Link(db.Merchant.ID.Equals(merchantId)),
		db.MerchantTrx.Amount.Set(amount),
		db.MerchantTrx.Status.Set(db.TrxStatusProcess),
	).Exec(context.Background())

	if errMerchTrx != nil {
		_, errDel := u.db.MerchantWallet.FindUnique(
			db.MerchantWallet.ID.Equals(mWallet.ID),
		).Update(
			db.MerchantWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		return nil, errMerchTrx
	}
	phone, okPhone := merchant.Phone()
	if !okPhone {
		_, errDel := u.db.MerchantWallet.FindUnique(
			db.MerchantWallet.ID.Equals(mWallet.ID),
		).Update(
			db.MerchantWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.MerchantTrx.FindUnique(
			db.MerchantTrx.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, errors.New("unable fetch merchant phone number")
	}
	result, err := u.dana.RequestWithdraw(u.sanitizePhone(phone), amount*100, mTrx.ID)
	if err != nil {
		_, errDel := u.db.MerchantWallet.FindUnique(
			db.MerchantWallet.ID.Equals(mWallet.ID),
		).Update(
			db.MerchantWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.MerchantTrx.FindUnique(
			db.MerchantTrx.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, err
	}
	if err := u.createTrxCompnay(db.TrxTypeReduction, db.TrxCompanyTypeMerchant, amount); err != nil {
		return nil, err
	}
	return result, nil
}

func (u LugoService) DriverRequestWithdraw(driverId string, amount int) (*utils.WithdrawRequest, error) {
	driver, errDriver := u.db.Driver.FindUnique(
		db.Driver.ID.Equals(driverId),
	).With(
		db.Driver.DriverWallet.Fetch(),
	).Exec(context.Background())
	if errDriver != nil {
		return nil, errDriver
	}
	wallet, ok := driver.DriverWallet()
	if !ok {
		return nil, errors.New("unable fetch merchant wallet")
	}
	if wallet.Balance < amount {
		return nil, errors.New("balance is not enough")
	}
	mWallet, errUpdate := u.db.DriverWallet.FindUnique(
		db.DriverWallet.ID.Equals(wallet.ID),
	).Update(
		db.DriverWallet.Balance.Decrement(amount),
	).Exec(context.Background())

	if errUpdate != nil {
		return nil, errUpdate
	}
	mTrx, errMerchTrx := u.db.DriverTrx.CreateOne(
		db.DriverTrx.TrxType.Set(db.TrxTypeReduction),
		db.DriverTrx.Driver.Link(db.Driver.ID.Equals(driverId)),
		db.DriverTrx.Amount.Set(amount),
		db.DriverTrx.Status.Set(db.TrxStatusProcess),
	).Exec(context.Background())

	if errMerchTrx != nil {
		_, errDel := u.db.DriverWallet.FindUnique(
			db.DriverWallet.ID.Equals(mWallet.ID),
		).Update(
			db.DriverWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.DriverTrx.FindUnique(
			db.DriverTrx.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, errMerchTrx
	}
	phone, okPhone := driver.Phone()
	if !okPhone {
		_, errDel := u.db.DriverWallet.FindUnique(
			db.DriverWallet.ID.Equals(mWallet.ID),
		).Update(
			db.DriverWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.DriverTrx.FindUnique(
			db.DriverTrx.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, errors.New("unable fetch driver phone number")
	}
	result, err := u.dana.RequestWithdraw(u.sanitizePhone(phone), amount*100, mTrx.ID)
	if err != nil {
		_, errDel := u.db.DriverWallet.FindUnique(
			db.DriverWallet.ID.Equals(mWallet.ID),
		).Update(
			db.DriverWallet.Balance.Increment(amount),
		).Exec(context.Background())
		if errDel != nil {
			return nil, errDel
		}
		_, errMTrx := u.db.DriverTrx.FindUnique(
			db.DriverTrx.ID.Equals(mTrx.ID),
		).Delete().Exec(context.Background())
		if errMTrx != nil {
			return nil, errMTrx
		}
		return nil, err
	}
	if err := u.createTrxCompnay(db.TrxTypeReduction, db.TrxCompanyTypeDriver, amount); err != nil {
		return nil, err
	}
	return result, nil
}

func (u LugoService) sanitizePhone(phoneNumber string) string {
	// Remove leading '+' and '0'
	re := regexp.MustCompile(`^[+0]*`)
	result := re.ReplaceAllString(phoneNumber, "")

	// Check if the remaining string starts with "62"
	if len(result) >= 2 && result[:2] != "62" {
		return phoneNumber
	}

	return result
}

func (u LugoService) formatPhoneNumber(phone string) string {
	// Remove non-digit characters
	numericPhone := regexp.MustCompile("\\D").ReplaceAllString(phone, "")

	// Check if the phone number starts with "0" and replace it with "62"
	if strings.HasPrefix(numericPhone, "0") {
		numericPhone = "62" + numericPhone[1:]
	}

	// Insert a hyphen at the appropriate position
	formattedPhone := numericPhone[:2] + "-" + numericPhone[2:]
	return formattedPhone
}

func (u LugoService) createTrxCompnay(trxType db.TrxType, trxFrom db.TrxCompanyType, amount int) error {
	_, err := u.db.TrxCompany.CreateOne(
		db.TrxCompany.TrxType.Set(trxType),
		db.TrxCompany.TrxFrom.Set(trxFrom),
		db.TrxCompany.Amount.Set(amount),
	).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (u LugoService) driverBonus(serviceType db.ServiceType, orderId string, driverId string, amount int) error {
	_, err := u.db.BonusDriver.CreateOne(
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

func (u LugoService) getPreviousDay() time.Time {
	currentTime := time.Now()

	currentHour := currentTime.Hour()

	adjustedTime := currentTime.Add(-time.Duration(currentHour) * time.Hour)
	return adjustedTime
}

func (u LugoService) getNextDay() time.Time {
	currentTime := time.Now()

	currentHour := currentTime.Hour()

	adjustedTime := currentTime.Add(time.Duration(currentHour) * time.Hour)
	return adjustedTime
}

func (u LugoService) getPreviousWeek() time.Time {
	currentTime := time.Now()
	currentDay := currentTime.Day()

	previousWeek := currentTime.AddDate(0, 0, -7-currentDay)
	return previousWeek
}

func (u LugoService) getNextWeek() time.Time {
	currentTime := time.Now()
	currentDay := currentTime.Day()

	nextWeek := currentTime.AddDate(0, 0, 7-currentDay)
	return nextWeek
}

func (u LugoService) getPreviousMonth() time.Time {
	currentTime := time.Now()

	previousMonth := currentTime.AddDate(0, -1, 0)
	return previousMonth
}

func (u LugoService) getNextMonth() time.Time {
	currentTime := time.Now()

	nextMonth := currentTime.AddDate(0, 1, 0)
	return nextMonth
}
