package services

import (
	"apps/order/db"
	"context"
	"errors"
	"fmt"
)

func (order OrderService) DriverSignOnOrder(orderId, driverId string) error {
	query := fmt.Sprintf(`
	UPDATE "order"
	SET "driver_id" = '%s'
	WHERE "id" = '%s'
	AND "driver_id" IS NULL
	`, driverId, orderId)
	_, err := order.database.Prisma.ExecuteRaw(query).Exec(context.Background())
	if err != nil {
		return err
	}
	orderDb, errGetOrderDb := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
	).Exec(context.Background())

	if errGetOrderDb != nil {
		return errGetOrderDb
	}
	if err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusDriverOtw)); err != nil {
		return err
	}
	if err := order.assignDriverOnFirestore(driverId, orderId); err != nil {
		return err
	}
	if err := order.sendMessageToApp(orderDb); err != nil {
		fmt.Printf("error send message to app: %s\n", err.Error())
		return nil
	}
	return nil
}

func (order OrderService) DriverRejectOrder(orderId string, driverId string) error {
	orderExists, errOrderExists := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Exec(context.Background())
	if errOrderExists != nil {
		return errOrderExists
	}
	_, errCreteOrderReject := order.database.OrderRejected.CreateOne(
		db.OrderRejected.Order.Link(db.Order.ID.Equals(orderExists.ID)),
		db.OrderRejected.Driver.Link(db.Driver.ID.Equals(driverId)),
	).Exec(context.Background())

	_, errUpdateOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.Driver.Unlink(),
		db.Order.Showable.Set(true),
	).Exec(context.Background())
	if errUpdateOrder != nil {
		return errUpdateOrder
	}
	errF := order.DeleteOrderForDriver(driverId, orderId)
	if errF != nil {
		return errF
	}
	if errCreteOrderReject != nil {
		return errCreteOrderReject
	}
	return nil
}

func (order OrderService) DriverAcceptOrder(orderId, driverId string) error {
	query := fmt.Sprintf(`
		UPDATE "order"
		SET driver_id = '%s'
		WHERE id = '%s'
		AND driver_id IS NULL
	`, driverId, driverId)
	_, errUpdateOrder := order.database.Prisma.ExecuteRaw(query).Exec(context.Background())
	if errUpdateOrder != nil {
		return errUpdateOrder
	}
	err := order.assignDriverOnFirestore(driverId, orderId)
	if err != nil {
		return err
	}
	errF := order.DeleteOrderForDriver(driverId, orderId)
	if errF != nil {
		return errF
	}
	if err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusDriverOtw)); err != nil {
		return err
	}
	return nil
}

func (order OrderService) ShippingOrder(orderId string) error {
	orderDb, errGetOrderDb := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Exec(context.Background())
	if errGetOrderDb != nil {
		return errGetOrderDb
	}
	if orderDb.OrderStatus == db.OrderStatusDriverOtw || orderDb.OrderStatus == db.OrderStatusDriverClose {
		_, errUpdateOrder := order.database.Order.FindUnique(
			db.Order.ID.Equals(orderId),
		).Update(
			db.Order.OrderStatus.Set(db.OrderStatusOtw),
		).Exec(context.Background())
		if errUpdateOrder != nil {
			return errUpdateOrder
		}

		if err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusOtw)); err != nil {
			return err
		}
		return nil
	}
	return nil
}

func (order OrderService) DriverClose(orderId string) error {
	orderDb, errGetOrderDb := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Exec(context.Background())
	if errGetOrderDb != nil {
		return errGetOrderDb
	}
	if orderDb.OrderStatus == db.OrderStatusDriverOtw {
		_, errUpdateOrder := order.database.Order.FindUnique(
			db.Order.ID.Equals(orderId),
		).Update(
			db.Order.OrderStatus.Set(db.OrderStatusDriverClose),
		).Exec(context.Background())
		if errUpdateOrder != nil {
			return errUpdateOrder
		}

		if err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusDriverClose)); err != nil {
			return err
		}
		return nil
	}
	return nil
}

func (order OrderService) FinishOrder(orderId string) error {

	orderDb, errOrder := order.fetchOrder(orderId)
	if errOrder != nil {
		return errOrder
	}
	driver, amount, errDriver := order.processDriver(orderDb)

	if errDriver != nil {
		return errDriver
	}

	if orderDb.OrderType == db.ServiceTypeFood || orderDb.OrderType == db.ServiceTypeMart {
		if err := order.processMerchant(orderDb); err != nil {
			return err
		}
	}
	if err := order.processAdmin(amount, driver, orderDb); err != nil {
		return err
	}
	return nil
}

func (order OrderService) fetchOrder(orderId string) (*db.OrderModel, error) {
	orderDb, errOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).With(
		db.Order.Driver.Fetch().With(
			db.Driver.DriverWallet.Fetch(),
		),
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch().With(
				db.Product.Merchant.Fetch().With(
					db.Merchant.MerchantWallet.Fetch(),
					db.Merchant.Details.Fetch(),
				),
			),
		),
	).Exec(context.Background())

	if errOrder != nil {
		return nil, errOrder
	}
	return orderDb, nil
}

func (order OrderService) processDriver(orderDb *db.OrderModel) (*db.DriverModel, float64, error) {
	driver, okDriver := orderDb.Driver()
	if !okDriver {
		return nil, 0, errors.New("unable fetch driver")
	}
	serviceFeeDriver, errGetServiceFeeDriver := order.database.ServiceFee.FindFirst(
		db.ServiceFee.ServiceType.Equals(orderDb.OrderType),
	).Exec(context.Background())

	if errGetServiceFeeDriver != nil {
		return nil, 0, errGetServiceFeeDriver
	}
	amount := float64(orderDb.ShippingCost) * float64(serviceFeeDriver.Percentage) / 100.0
	amountBonus := float64(amount) * 5.0 / 100.0
	totalAmount := orderDb.ShippingCost - int(amount)

	driverWallet, okDriverWallet := driver.DriverWallet()
	if orderDb.PaymentType == db.PaymentTypeDana {
		if !okDriverWallet {
			return nil, 0, errors.New("unable fetch driver wallet")
		}
		errDriverWallet := order.incrementDriverWallet(driverWallet, totalAmount)

		if errDriverWallet != nil {
			return nil, 0, errDriverWallet
		}
		errDriverTrx := order.createTrxDriver(driver, db.TrxTypeAdjustment, totalAmount)
		if errDriverTrx != nil {
			return nil, 0, errDriverTrx
		}
		errTrxCmp := order.createTrxCompnay(db.TrxTypeAdjustment, db.TrxCompanyTypeDriver, int(amount))
		if errTrxCmp != nil {
			return nil, 0, errTrxCmp
		}
	}
	if !okDriverWallet {
		return nil, 0, errors.New("unable fetch driver wallet")
	}
	errDriverWallet := order.decrementDriverWallet(driverWallet, orderDb.ShippingCost)

	if errDriverWallet != nil {
		return nil, 0, errDriverWallet
	}
	errDriverTrx := order.createTrxDriver(driver, db.TrxTypeReduction, orderDb.ShippingCost)
	if errDriverTrx != nil {
		return nil, 0, errDriverTrx
	}
	errDriverWallet1 := order.incrementDriverWallet(driverWallet, totalAmount)

	if errDriverWallet1 != nil {
		return nil, 0, errDriverWallet
	}
	errDriverTrx1 := order.createTrxDriver(driver, db.TrxTypeAdjustment, totalAmount)
	if errDriverTrx1 != nil {
		return nil, 0, errDriverTrx
	}

	errTrxCmp := order.createTrxCompnay(db.TrxTypeAdjustment, db.TrxCompanyTypeDriver, int(amount))
	if errTrxCmp != nil {
		return nil, 0, errTrxCmp
	}

	order.driverBonus(orderDb.OrderType, orderDb.ID, driver.ID, int(amountBonus))
	if err := order.createTrxCompnay(db.TrxTypeReduction, db.TrxCompanyTypeBonusDriver, int(amountBonus)); err != nil {
		return nil, 0, err
	}

	return driver, amount, nil
}
func (order OrderService) incrementDriverWallet(wallet *db.DriverWalletModel, totalAmount int) error {
	_, errDriverWallet := order.database.DriverWallet.FindUnique(
		db.DriverWallet.ID.Equals(wallet.ID),
	).Update(
		db.DriverWallet.Balance.Increment(totalAmount),
	).Exec(context.Background())

	if errDriverWallet != nil {
		return errDriverWallet
	}
	return nil
}
func (order OrderService) decrementDriverWallet(wallet *db.DriverWalletModel, totalAmount int) error {
	_, errDriverWallet := order.database.DriverWallet.FindUnique(
		db.DriverWallet.ID.Equals(wallet.ID),
	).Update(
		db.DriverWallet.Balance.Decrement(totalAmount),
	).Exec(context.Background())

	if errDriverWallet != nil {
		return errDriverWallet
	}
	return nil
}
func (order OrderService) createTrxDriver(driver *db.DriverModel, trxTyp db.TrxType, amount int) error {
	_, err := order.database.DriverTrx.CreateOne(
		db.DriverTrx.TrxType.Set(trxTyp),
		db.DriverTrx.Driver.Link(db.Driver.ID.Equals(driver.ID)),
		db.DriverTrx.Amount.Set(amount),
		db.DriverTrx.Status.Set(db.TrxStatusSuccess),
	).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) processMerchant(orderDb *db.OrderModel) error {
	orderItem := orderDb.OrderItems()
	errSeamless := order.checkOwnerOfProduct(orderItem)
	if errSeamless != nil {
		return errSeamless
	}
	merchant := orderItem[0].Product().Merchant()
	merchantDetail, okMDetails := orderItem[0].Product().Merchant().Details()
	if !okMDetails {
		return errors.New("merchant not verified yet")
	}
	serviceFeeMerch, errServiceFeeMerch := order.database.ServiceFee.FindFirst(
		db.ServiceFee.AccountType.Equals(merchantDetail.Badge),
		db.ServiceFee.ServiceType.Equals(orderDb.OrderType),
	).Exec(context.Background())
	if errServiceFeeMerch != nil {
		return errServiceFeeMerch
	}

	merchantWallet, ok := merchant.MerchantWallet()
	orderFee := float64(orderDb.GrossAmount) * float64(serviceFeeMerch.Percentage) / 100
	totalIncomeMerchant := orderDb.GrossAmount - int(orderFee)

	if orderDb.PaymentType == db.PaymentTypeDana {
		if !ok {
			return errors.New("unable fetch merchant wallet")
		}
		err := order.incrementMerchantWallet(totalIncomeMerchant, merchantWallet)
		if err != nil {
			return err
		}
		errCreateTrxMerch := order.createTrxMerchant(merchant, db.TrxTypeAdjustment, totalIncomeMerchant)
		if errCreateTrxMerch != nil {
			return errCreateTrxMerch
		}

		errTrxCmp := order.createTrxCompnay(db.TrxTypeAdjustment, db.TrxCompanyTypeMerchant, int(orderFee))
		if errTrxCmp != nil {
			return errTrxCmp
		}
		return nil
	}

	if !ok {
		return errors.New("unable fetch merchant wallet")
	}
	errDecrementMerchWallet := order.decrementMerchantWallet(orderDb.GrossAmount, merchantWallet)
	if errDecrementMerchWallet != nil {
		return errDecrementMerchWallet
	}
	errReductionTrxMerch := order.createTrxMerchant(merchant, db.TrxTypeReduction, orderDb.GrossAmount)
	if errReductionTrxMerch != nil {
		return errReductionTrxMerch
	}
	errAdjustMerchWallet := order.incrementMerchantWallet(totalIncomeMerchant, merchantWallet)
	if errAdjustMerchWallet != nil {
		return errAdjustMerchWallet
	}
	errCreateTrxMerch := order.createTrxMerchant(merchant, db.TrxTypeAdjustment, totalIncomeMerchant)
	if errCreateTrxMerch != nil {
		return errCreateTrxMerch
	}

	errTrxCmp := order.createTrxCompnay(db.TrxTypeAdjustment, db.TrxCompanyTypeMerchant, int(orderFee))
	if errTrxCmp != nil {
		return errTrxCmp
	}
	return nil
}
func (order OrderService) createTrxMerchant(merchant *db.MerchantModel, trxTyp db.TrxType, totalIncomeMerchant int) error {
	_, errTrxMerch := order.database.MerchantTrx.CreateOne(
		db.MerchantTrx.TrxType.Set(trxTyp),
		db.MerchantTrx.Merchant.Link(db.Merchant.ID.Equals(merchant.ID)),
		db.MerchantTrx.Amount.Set(totalIncomeMerchant),
	).Exec(context.Background())
	if errTrxMerch != nil {
		return errTrxMerch
	}
	return nil
}
func (order OrderService) incrementMerchantWallet(amount int, merchantWallet *db.MerchantWalletModel) error {
	_, errUpdateMerchWallet := order.database.MerchantWallet.FindUnique(
		db.MerchantWallet.ID.Equals(merchantWallet.ID),
	).Update(
		db.MerchantWallet.Balance.Increment(amount),
	).Exec(context.Background())
	if errUpdateMerchWallet != nil {
		return errUpdateMerchWallet
	}
	return nil
}
func (order OrderService) decrementMerchantWallet(amount int, merchantWallet *db.MerchantWalletModel) error {
	_, errUpdateMerchWallet := order.database.MerchantWallet.FindUnique(
		db.MerchantWallet.ID.Equals(merchantWallet.ID),
	).Update(
		db.MerchantWallet.Balance.Decrement(amount),
	).Exec(context.Background())
	if errUpdateMerchWallet != nil {
		return errUpdateMerchWallet
	}
	return nil
}

func (order OrderService) checkOwnerOfProduct(items []db.OrderItemModel) error {
	for index := 1; index < len(items); index++ {
		merchantId := items[index-1].Product().MerchantID
		currentMerchantId := items[index].Product().MerchantID
		if merchantId != currentMerchantId {
			return errors.New("please order from the same merchant")
		}
	}
	return nil
}

func (order OrderService) processAdmin(amount float64, driver *db.DriverModel, orderM *db.OrderModel) error {
	referralId, okReferralID := driver.ReferalID()
	if okReferralID {
		referral, err := order.database.Referal.FindUnique(
			db.Referal.ID.Equals(referralId),
		).With(
			db.Referal.Admin.Fetch().With(
				db.Admin.Role.Fetch().With(),
				db.Admin.AdminWallet.Fetch(),
			),
		).Exec(context.Background())
		if err != nil {
			return err
		}
		role := referral.Admin().Role()
		if role[0].Name == "KORLAP" && orderM.OrderType != db.ServiceTypeBike || orderM.OrderType != db.ServiceTypeCar {
			return nil
		}
		korlapFee, errK := order.database.KorlapFee.FindFirst(
			db.KorlapFee.AdminType.Equals(db.AdminType(role[0].Name)),
		).Exec(context.Background())
		if errK != nil {
			return errK
		}
		fee := amount * float64(korlapFee.Percentage) / 100.0

		adminWallet, okAdminWallet := referral.Admin().AdminWallet()
		if !okAdminWallet {
			wallet, errGetAdminWallet := order.database.AdminWallet.CreateOne(
				db.AdminWallet.Admin.Link(db.Admin.ID.Equals(referral.AdminID)),
			).Exec(context.Background())
			if errGetAdminWallet != nil {
				return errGetAdminWallet
			}
			_, errAdjustBalanceAdmin := order.database.AdminWallet.FindUnique(
				db.AdminWallet.AdminID.Equals(wallet.AdminID),
			).Update(
				db.AdminWallet.Balance.Increment(int(fee)),
			).Exec(context.Background())
			if errAdjustBalanceAdmin != nil {
				return errAdjustBalanceAdmin
			}
			_, errCreateTrxAdmin := order.database.TrxAdmin.CreateOne(
				db.TrxAdmin.TrxType.Set(db.TrxTypeAdjustment),
				db.TrxAdmin.Amount.Set(int(fee)),
				db.TrxAdmin.Admin.Link(db.Admin.ID.Equals(referral.AdminID)),
				db.TrxAdmin.Note.Set("Referral Transactions"),
			).Exec(context.Background())
			if errCreateTrxAdmin != nil {
				return errCreateTrxAdmin
			}
		}
		_, errGetAdminWallet := order.database.AdminWallet.FindUnique(
			db.AdminWallet.ID.Equals(adminWallet.ID),
		).Update(
			db.AdminWallet.Balance.Set(adminWallet.Balance + int(fee)),
		).Exec(context.Background())
		if errGetAdminWallet != nil {
			return errGetAdminWallet
		}
		_, errCreateTrxAdmin := order.database.TrxAdmin.CreateOne(
			db.TrxAdmin.TrxType.Set(db.TrxTypeAdjustment),
			db.TrxAdmin.Amount.Set(int(fee)),
			db.TrxAdmin.Admin.Link(db.Admin.ID.Equals(referral.AdminID)),
			db.TrxAdmin.Note.Set("Referral Transactions"),
		).Exec(context.Background())
		if errCreateTrxAdmin != nil {
			return errCreateTrxAdmin
		}

		errTrxCmp := order.createTrxCompnay(db.TrxTypeReduction, db.TrxCompanyTypeAdmin, int(fee))
		if errTrxCmp != nil {
			return errTrxCmp
		}

	}
	return nil
}
