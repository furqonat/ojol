package services

import (
	"apps/order/db"
	"context"
	"time"
)

type TotalOrder struct {
	TotalDone   int     `json:"done"`
	TotalCancel int     `json:"cancel"`
	TotalIncome float64 `json:"income"`
}

func (order OrderService) MerchantAcceptOrder(orderId string) error {
	_, errGetOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.OrderStatus.Set(db.OrderStatusFindDriver),
	).Exec(context.Background())
	if errGetOrder != nil {
		return nil
	}
	err := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusFindDriver))
	if err != nil {
		return err
	}
	return nil
}

func (order OrderService) MerchantRejectOrder(orderId string) error {
	_, errGetOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.OrderStatus.Set(db.OrderStatusCanceled),
	).Exec(context.Background())
	if errGetOrder != nil {
		return nil
	}

	_, err := order.CancelOrder(orderId, "Merchant rejected or not responding")
	if err != nil {
		return err
	}
	errFrs := order.updateTrxStatusOnFirestore(orderId, string(db.OrderStatusCanceled))
	if errFrs != nil {
		return errFrs
	}
	return nil
}

func (order OrderService) GetOrderMerchants(merchantId string, take, skip int) ([]db.OrderModel, error) {
	orders, err := order.database.Order.FindMany(
		db.Order.OrderItems.Some(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
		db.Order.OrderType.In(
			[]db.ServiceType{
				db.ServiceTypeMart,
				db.ServiceTypeFood,
			},
		),
		db.Order.DriverID.Not(
			"NULL",
		),
	).With(
		db.Order.Customer.Fetch(),
		db.Order.Transactions.Fetch(),
		db.Order.OrderDetail.Fetch(),
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
		db.Order.Driver.Fetch().With(
			db.Driver.DriverDetails.Fetch().With(
				db.DriverDetails.Vehicle.Fetch(),
			),
		),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return orders, nil
}

func (order OrderService) MerchantGetSellStatusInDay(merchantId string) (*TotalOrder, error) {
	totalCanceled, errorCancel := order.getSellStatusInDay(merchantId, []db.OrderStatus{db.OrderStatusCanceled})
	if errorCancel != nil {
		return nil, errorCancel
	}

	totalDone, errorDone := order.getSellStatusInDay(merchantId, []db.OrderStatus{db.OrderStatusDone})
	if errorDone != nil {
		return nil, errorCancel
	}

	totalIncome, errIncome := order.getMerchantIncomeInDay(merchantId)
	if errIncome != nil {
		return nil, errIncome
	}
	return &TotalOrder{
		TotalDone:   len(totalDone),
		TotalCancel: len(totalCanceled),
		TotalIncome: float64(totalIncome),
	}, nil

}

func (order OrderService) MerchantGetSellInDay(merchantId string) ([]db.OrderModel, []db.OrderModel, []db.OrderModel, error) {
	canceled, errorCancel := order.getSellStatusInDay(merchantId, []db.OrderStatus{db.OrderStatusWaitingMerchant, db.OrderStatusCreated})
	if errorCancel != nil {
		return nil, nil, nil, errorCancel
	}

	done, errorDone := order.getSellStatusInDay(merchantId, []db.OrderStatus{db.OrderStatusDone})
	if errorDone != nil {
		return nil, nil, nil, errorCancel
	}
	currentTime := time.Now()
	oneDayAgo := currentTime.Add(-24 * time.Hour)
	nextDay := currentTime.Add(24 * time.Hour)
	orderDb, errOrder := order.database.Order.FindMany(
		db.Order.CreatedAt.Gte(oneDayAgo),
		db.Order.CreatedAt.Lte(nextDay),
		db.Order.OrderItems.Some(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
		db.Order.OrderStatus.NotIn([]db.OrderStatus{
			db.OrderStatusDone,
			db.OrderStatusCanceled,
			db.OrderStatusCreated,
			db.OrderStatusExpired,
			db.OrderStatusWaitingMerchant,
		}),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
		db.Order.Customer.Fetch(),
		db.Order.Driver.Fetch().With(
			db.Driver.DriverDetails.Fetch().With(
				db.DriverDetails.Vehicle.Fetch(),
			),
		),
		db.Order.OrderDetail.Fetch(),
	).Exec(context.Background())
	if errOrder != nil {
		return nil, nil, nil, errOrder
	}
	return canceled, done, orderDb, nil

}

func (order OrderService) MerchantGetOrders(merchantId string, dayTime string) ([]db.OrderModel, error) {
	if dayTime == "day" {
		return order.merchantGetOrderInDay(merchantId)
	} else if dayTime == "week" {
		return order.merchantGetOrderInWeek(merchantId)
	} else if dayTime == "month" {
		return order.merchantGetOrderInMonth(merchantId)
	}
	return nil, nil
}

func (order OrderService) merchantGetOrderInDay(merchantId string) ([]db.OrderModel, error) {
	orderDb, errorOrderDb := order.database.Order.FindMany(
		db.Order.OrderItems.Some(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
		db.Order.CreatedAt.Lte(order.getNextDay()),
		db.Order.CreatedAt.Gte(order.getPreviousDay()),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
		db.Order.Customer.Fetch(),
		db.Order.Driver.Fetch().With(
			db.Driver.DriverDetails.Fetch().With(
				db.DriverDetails.Vehicle.Fetch(),
			),
		),
		db.Order.OrderDetail.Fetch(),
	).Exec(context.Background())
	if errorOrderDb != nil {
		return nil, errorOrderDb
	}

	return orderDb, nil
}

func (order OrderService) merchantGetOrderInWeek(merchantId string) ([]db.OrderModel, error) {
	orderDb, errorOrderDb := order.database.Order.FindMany(
		db.Order.OrderItems.Some(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
		db.Order.CreatedAt.Lte(order.getNextWeek()),
		db.Order.CreatedAt.Gte(order.getPreviousWeek()),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
		db.Order.Customer.Fetch(),
		db.Order.Driver.Fetch().With(
			db.Driver.DriverDetails.Fetch().With(
				db.DriverDetails.Vehicle.Fetch(),
			),
		),
		db.Order.OrderDetail.Fetch(),
	).Exec(context.Background())
	if errorOrderDb != nil {
		return nil, errorOrderDb
	}

	return orderDb, nil
}

func (order OrderService) merchantGetOrderInMonth(merchantId string) ([]db.OrderModel, error) {
	orderDb, errorOrderDb := order.database.Order.FindMany(
		db.Order.OrderItems.Some(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
		db.Order.CreatedAt.Lte(order.getNextMonth()),
		db.Order.CreatedAt.Gte(order.getPreviousMonth()),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
		db.Order.Customer.Fetch(),
		db.Order.Driver.Fetch().With(
			db.Driver.DriverDetails.Fetch().With(
				db.DriverDetails.Vehicle.Fetch(),
			),
		),
		db.Order.OrderDetail.Fetch(),
	).Exec(context.Background())
	if errorOrderDb != nil {
		return nil, errorOrderDb
	}

	return orderDb, nil
}

func (order OrderService) getSellStatusInDay(merchantId string, status []db.OrderStatus) ([]db.OrderModel, error) {
	currentTime := time.Now()
	oneDayAgo := currentTime.Add(-24 * time.Hour)
	nextDay := currentTime.Add(24 * time.Hour)
	orderDb, errOrder := order.database.Order.FindMany(
		db.Order.CreatedAt.Gte(oneDayAgo),
		db.Order.CreatedAt.Lte(nextDay),
		db.Order.OrderItems.Some(
			db.OrderItem.Product.Where(
				db.Product.MerchantID.Equals(merchantId),
			),
		),
		db.Order.OrderStatus.In(status),
	).With(
		db.Order.OrderItems.Fetch().With(
			db.OrderItem.Product.Fetch(),
		),
		db.Order.Customer.Fetch(),
		db.Order.Driver.Fetch().With(
			db.Driver.DriverDetails.Fetch().With(
				db.DriverDetails.Vehicle.Fetch(),
			),
		),
		db.Order.OrderDetail.Fetch(),
	).Exec(context.Background())
	if errOrder != nil {
		return nil, errOrder
	}
	return orderDb, nil
}

func (order OrderService) getMerchantIncomeInDay(merchantId string) (int, error) {
	currentTime := time.Now()
	oneDayAgo := currentTime.Add(-24 * time.Hour)
	nextDay := currentTime.Add(24 * time.Hour)
	orderDb, errOrder := order.database.MerchantTrx.FindMany(
		db.MerchantTrx.CreatedAt.Gte(oneDayAgo),
		db.MerchantTrx.CreatedAt.Lte(nextDay),
		db.MerchantTrx.MerchantID.Equals(merchantId),
		db.MerchantTrx.TrxType.Equals(db.TrxTypeAdjustment),
		db.MerchantTrx.Status.Equals(db.TrxStatusSuccess),
	).Exec(context.Background())
	if errOrder != nil {
		return 0, errOrder
	}
	currentBalance := 0

	for _, b := range orderDb {
		currentBalance += b.Amount
	}
	return currentBalance, nil
}
