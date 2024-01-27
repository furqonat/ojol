package services

import (
	"apps/order/db"
	"apps/order/utils"
	"context"
	"errors"
	"fmt"
	"strings"
	"time"

	"cloud.google.com/go/firestore"
	"firebase.google.com/go/messaging"
)

type OrderService struct {
	database    utils.Database
	firestore   Firestore
	messaging   *Messaging
	danaService DanaService
}

type CreateOrderType struct {
	db.OrderModel
	Product     []Inner  `json:"product,omitempty"`
	Location    Location `json:"location,omitempty"`
	Destination Location `json:"destination,omitempty"`
	DiscountID  *string  `json:"discount_id,omitempty"`
}

type Inner struct {
	ProductId *string `json:"product_id,omitempty"`
	Quantity  *int    `json:"quantity,omitempty"`
}

type Location struct {
	Address   string  `json:"address"`
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

type QueryRawNearly struct {
	DriverID        string  `json:"driver_id"`
	DriverLatitude  float64 `json:"driver_lat"`
	DriverLongitude float64 `json:"driver_lon"`
	Distance        float64 `json:"distance"`
}

func NewOrderService(
	database utils.Database,
	firestore Firestore,
	messaging *Messaging,
	danaService DanaService,
) *OrderService {
	return &OrderService{
		database:    database,
		firestore:   firestore,
		messaging:   messaging,
		danaService: danaService,
	}
}

func (order OrderService) deleteOrder(orderId string) (*db.OrderModel, error) {
	return order.database.Order.FindUnique(db.Order.ID.Equals(orderId)).Delete().Exec(context.Background())
}

func (order OrderService) deleteTrx(orderId string) (*db.TransactionsModel, error) {
	return order.database.Transactions.FindUnique(db.Transactions.ID.Equals(orderId)).Delete().Exec(context.Background())
}

func (order OrderService) CreateOrder(
	ptrOrderModel *CreateOrderType,
	customerId string,
) (*string, *db.TransactionDetailModel, error) {
	currentTime := time.Now()

	fifteenMinutesLater := currentTime.Add(15 * time.Minute)
	orderExists, err := order.database.Order.FindMany(
		db.Order.CustomerID.Equals(customerId),
		db.Order.OrderStatus.NotIn([]db.OrderStatus{
			db.OrderStatusDone,
			db.OrderStatusCanceled,
		}),
		db.Order.OrderType.Equals(ptrOrderModel.OrderType),
		db.Order.CreatedAt.Lte(fifteenMinutesLater),
	).With(
		db.Order.Transactions.Fetch(),
	).Take(1).Exec(context.Background())

	if err != nil {
		return nil, nil, err
	}

	if len(orderExists) > 0 {
		orderDb, errOrder := order.database.Order.FindUnique(
			db.Order.ID.Equals(orderExists[0].ID),
		).With(
			db.Order.Transactions.Fetch().With(db.Transactions.Detail.Fetch()),
		).Exec(context.Background())
		if errOrder != nil {
			return nil, nil, errOrder
		}
		trx, okTrx := orderDb.Transactions()
		if !okTrx {
			return nil, nil, errors.New("unable fetch transactions")
		}
		detail, okDetail := trx.Detail()
		if !okDetail {
			return nil, nil, errors.New("unable fetch transactions detail")
		}

		return &trx.OrderID, detail, nil
	}

	createOrderResult, errCreateOrder := order.database.Order.CreateOne(
		db.Order.OrderType.Set(ptrOrderModel.OrderType),
		db.Order.PaymentType.Set(ptrOrderModel.PaymentType),
		db.Order.Customer.Link(db.Customer.ID.Equals(customerId)),
		db.Order.GrossAmount.Set(ptrOrderModel.GrossAmount),
		db.Order.NetAmount.Set(ptrOrderModel.NetAmount),
		db.Order.TotalAmount.Set(ptrOrderModel.TotalAmount),
		db.Order.ShippingCost.Set(ptrOrderModel.ShippingCost),
	).Exec(context.Background())

	if errCreateOrder != nil {
		return nil, nil, errCreateOrder
	}

	if ptrOrderModel.DiscountID != nil {
		getD, errGetD := order.database.Discount.FindUnique(
			db.Discount.ID.Equals(*ptrOrderModel.DiscountID),
		).Exec(context.Background())
		if getD.TrxType != createOrderResult.OrderType {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("unable create order discount code not for this order")
		}
		if errGetD != nil {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("unable create order failed on discount")
		}
		_, errL := order.database.Order.FindUnique(
			db.Order.ID.Equals(createOrderResult.ID),
		).Update(
			db.Order.Discount.Link(db.Discount.ID.Equals(*ptrOrderModel.DiscountID)),
			db.Order.NetAmount.Decrement(getD.Amount),
		).Exec(context.Background())
		if errL != nil {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("unable create order failed on discount")
		}
	}

	if ptrOrderModel.OrderType == db.ServiceTypeFood || ptrOrderModel.OrderType == db.ServiceTypeMart {
		prod, errProd := order.database.Product.FindUnique(
			db.Product.ID.Equals(*ptrOrderModel.Product[0].ProductId),
		).With(
			db.Product.Merchant.Fetch().With(
				db.Merchant.Details.Fetch(),
				db.Merchant.MerchantWallet.Fetch(),
			),
		).Exec(context.Background())
		if errProd != nil {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errProd
		}

		merchant := prod.Merchant()
		merchantWallet, okWallet := merchant.MerchantWallet()

		if !okWallet {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("unable fetch merchant wallet")
		}

		if !merchant.IsOpen {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("merchant not open")
		}

		_, okDetail := merchant.Details()

		if !okDetail {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("merchant not verified yet")
		}

		if merchantWallet.Balance < createOrderResult.TotalAmount {
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errors.New("insufficient balance")
		}

		if err := order.sendMessageToMerchant(prod.MerchantID, "Pesanan Baru!", "segera siapkan pesanan nya sebelum driver datang!"); err != nil {
			fmt.Printf("Unable send message to merchant %s", err.Error())
		}
		for _, product := range ptrOrderModel.Product {

			if product.ProductId == nil {
				order.deleteOrder(createOrderResult.ID)
				return nil, nil, errors.New("product id not found")
			}

			if product.Quantity != nil && *product.Quantity == 0 {
				order.deleteOrder(createOrderResult.ID)
				return nil, nil, errors.New("quantity must be greater than 0")
			}

			if product.Quantity == nil {
				order.deleteOrder(createOrderResult.ID)
				return nil, nil, errors.New("please provide quantity")
			}
			_, errCreateOrderItem := order.database.OrderItem.CreateOne(
				db.OrderItem.Product.Link(db.Product.ID.EqualsIfPresent(product.ProductId)),
				db.OrderItem.Quantity.SetIfPresent(product.Quantity),
				db.OrderItem.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
			).Exec(context.Background())

			if errCreateOrderItem != nil {
				order.deleteOrder(createOrderResult.ID)
				return nil, nil, errCreateOrderItem
			}
		}
	}
	_, errCreateOrderDetail := order.database.OrderDetail.CreateOne(
		db.OrderDetail.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
		db.OrderDetail.Latitude.Set(ptrOrderModel.Location.Latitude),
		db.OrderDetail.Longitude.Set(ptrOrderModel.Location.Longitude),
		db.OrderDetail.Address.Set(ptrOrderModel.Location.Address),
		db.OrderDetail.DstLatitude.Set(ptrOrderModel.Destination.Latitude),
		db.OrderDetail.DstLongitude.Set(ptrOrderModel.Destination.Longitude),
		db.OrderDetail.DstAddress.Set(ptrOrderModel.Destination.Address),
	).Exec(context.Background())
	if errCreateOrderDetail != nil {
		order.deleteOrder(createOrderResult.ID)
		return nil, nil, errCreateOrderDetail
	}
	trx, errCreateTrx := order.database.Transactions.CreateOne(
		db.Transactions.Type.Set(createOrderResult.OrderType),
		db.Transactions.Order.Link(db.Order.ID.Equals(createOrderResult.ID)),
	).Exec(context.Background())

	if errCreateTrx != nil {
		_, err := order.deleteOrder(createOrderResult.ID)
		if err != nil {
			return nil, nil, err
		}
		return nil, nil, errCreateTrx
	}

	errCreateTrxFirestore := order.createTrxOnFirestore(createOrderResult, trx)

	if errCreateTrxFirestore != nil {
		order.deleteTrx(trx.ID)
		order.deleteOrder(createOrderResult.ID)
		return nil, nil, errCreateTrxFirestore
	}
	if ptrOrderModel.PaymentType == db.PaymentTypeDana {
		currentTime := time.Now()

		// Add 1 hour to the current time
		oneHourLater := currentTime.Add(time.Hour)

		formattedTime := oneHourLater.Format(utils.DanaDateFormat)

		data, errDana := order.danaService.CreateNewOrder(
			formattedTime,
			"transactionType",
			fmt.Sprintf("Order:%s", ptrOrderModel.OrderType),
			createOrderResult.ID,
			ptrOrderModel.TotalAmount*100,
			"riskObjectId",
			"riskObjectCode",
			"riskObjectOperator",
			"",
		)
		if errDana != nil {
			println(errDana.Error())
			order.deleteTrx(trx.ID)
			order.deleteOrder(createOrderResult.ID)
			return nil, nil, errDana
		}
		createTrxDetail, errCreateTrxDetail := order.database.TransactionDetail.CreateOne(
			db.TransactionDetail.Transactions.Link(db.Transactions.ID.Equals(trx.ID)),
			db.TransactionDetail.CheckoutURL.Set(data.CheckoutUrl),
			db.TransactionDetail.AcquirementID.Set(data.AcquirementId),
			db.TransactionDetail.MerchantTransID.Set(data.MerchantTransId),
		).Exec(context.Background())
		if errCreateTrxDetail != nil {
			return nil, nil, errCreateTrxDetail
		}
		return &createOrderResult.ID, createTrxDetail, nil
	} else {

		createTrxDetail, errCreateTrxDetail := order.database.TransactionDetail.CreateOne(
			db.TransactionDetail.Transactions.Link(db.Transactions.ID.Equals(trx.ID)),
			db.TransactionDetail.CheckoutURL.Set("CASH"),
			db.TransactionDetail.AcquirementID.Set("CASH"),
			db.TransactionDetail.MerchantTransID.Set(createOrderResult.ID),
		).Exec(context.Background())
		if errCreateTrxDetail != nil {
			return nil, nil, errCreateTrxDetail
		}
		return &createOrderResult.ID, createTrxDetail, nil

	}
}

func (order OrderService) CancelOrder(orderId string, reason string) (*string, error) {
	_, err := order.danaService.CancelOrder(orderId, reason)
	if err != nil {
		return nil, err
	}
	orderDb, errOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).With(
		db.Order.Transactions.Fetch(),
	).Update(
		db.Order.OrderStatus.Set(db.OrderStatusCanceled),
	).Exec(context.Background())
	if errOrder != nil {
		return nil, errOrder
	}

	_, errRefund := order.danaService.RefundOrder(orderId, reason, orderDb.TotalAmount*100)

	if errRefund != nil {
		println("refund error", errRefund.Error())
		return nil, errRefund
	}
	trx, okTrx := orderDb.Transactions()

	if !okTrx {
		return nil, errors.New("unable fetch transactions")
	}
	_, errUpdateTrx := order.database.Transactions.FindUnique(
		db.Transactions.ID.Equals(trx.ID),
	).Update(
		db.Transactions.Status.Set(db.TransactionStatusCanceled),
	).Exec(context.Background())

	if errUpdateTrx != nil {
		return nil, errUpdateTrx
	}
	_, er := order.firestore.Client.Collection("transactions").Doc(orderId).Update(context.Background(), []firestore.Update{
		{
			Path:  "status",
			Value: db.OrderStatusCanceled,
		},
	})
	if er != nil {
		return nil, er
	}
	return &trx.ID, nil
}

func (order OrderService) GetOrder(orderId string) (*db.OrderModel, error) {
	getOrder, err := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).With(
		db.Order.OrderDetail.Fetch(),
		db.Order.OrderItems.Fetch(),
		db.Order.Customer.Fetch(),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return getOrder, nil
}

func (order OrderService) GetAvaliableOrder(take, skip int) ([]db.OrderModel, int, error) {
	orders, errGetOrders := order.database.Order.FindMany(
		db.Order.Showable.Equals(true),
		db.Order.DriverID.IsNull(),
		db.Order.OrderStatus.In([]db.OrderStatus{
			db.OrderStatusCreated,
			db.OrderStatusFindDriver,
		}),
	).With(
		db.Order.OrderDetail.Fetch(),
	).Take(take).Skip(skip).Exec(context.Background())

	total, errTotalOrders := order.database.Order.FindMany(
		db.Order.Showable.Equals(true),
		db.Order.DriverID.IsNull(),
		db.Order.OrderStatus.In([]db.OrderStatus{
			db.OrderStatusCreated,
			db.OrderStatusFindDriver,
		}),
	).Exec(context.Background())
	if errGetOrders != nil {
		return nil, 0, errGetOrders
	}

	if errTotalOrders != nil {
		return nil, 0, errTotalOrders
	}
	return orders, len(total), nil
}

func (order OrderService) CustomerGetOrders(take, skip int, customerId string) ([]db.OrderModel, int, error) {
	orders, errOrders := order.database.Order.FindMany(
		db.Order.CustomerID.Equals(customerId),
	).Take(take).Skip(skip).With(
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
	if errOrders != nil {
		return nil, 0, errOrders
	}
	total, erTotal := order.database.Order.FindMany(
		db.Order.CustomerID.Equals(customerId),
	).Exec(context.Background())

	if erTotal != nil {
		return nil, 0, erTotal
	}
	return orders, len(total), nil
}

func (order OrderService) DriverGetOrders(take, skip int, driverId string) ([]db.OrderModel, int, error) {
	orders, errOrders := order.database.Order.FindMany(
		db.Order.DriverID.Equals(driverId),
	).Take(take).Skip(skip).With(
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
	if errOrders != nil {
		return nil, 0, errOrders
	}
	total, erTotal := order.database.Order.FindMany(
		db.Order.DriverID.Equals(driverId),
	).Exec(context.Background())

	if erTotal != nil {
		return nil, 0, erTotal
	}
	return orders, len(total), nil
}

func (order OrderService) FindGoodAndNearlyDriver(orderId string, latitude, longitude float64) error {
	orderDb, err := order.database.Order.FindUnique(db.Order.ID.Equals(orderId)).Exec(context.Background())
	if err != nil {
		return err
	}
	rejectedOrder, errRejectedOrder := order.database.OrderRejected.FindMany(
		db.OrderRejected.OrderID.Equals(orderId),
	).Exec(context.Background())
	if errRejectedOrder != nil {
		return errRejectedOrder
	}
	var disableDriverId []string
	for _, rejected := range rejectedOrder {
		driverId, okDriverId := rejected.DriverID()
		if okDriverId {
			disableDriverId = append(disableDriverId, driverId)
		}
	}
	query := fmt.Sprintf(`
	SELECT *
	FROM (
		SELECT
  		  driver_details.driver_id,
  		  current_lat AS driver_lat,
  		  current_lng AS driver_lon,
  		  ST_DistanceSphere(
  		    ST_SetSRID(ST_MakePoint(current_lng::FLOAT, current_lat::FLOAT), 4326),
  		    ST_SetSRID(ST_MakePoint(%f, %f), 4326)
  		  ) AS distance
		FROM
		  driver_details
		JOIN driver
		  ON driver.id = driver_details.driver_id
		JOIN driver_wallet
		  ON driver.id = driver_wallet.driver_id
		JOIN driver_settings
		  ON driver.id = driver_settings.driver_id
		WHERE driver_wallet.balance > %d
		AND driver.status = 'ACTIVE'
		AND driver_settings.auto_bid = TRUE
		AND driver.is_online = TRUE
		 %s
		 %s
	) AS subquery
	WHERE distance < 15000
	ORDER BY
	  distance
	LIMIT 1
	`,
		longitude,
		latitude,
		orderDb.TotalAmount,
		order.driverSettings(orderDb.OrderType, orderDb.TotalAmount),
		order.rejectedDriver(disableDriverId),
	)
	res := []QueryRawNearly{}
	errQuery := order.database.Prisma.QueryRaw(query).Exec(context.Background(), &res)
	if errQuery != nil {
		return errQuery
	}
	if len(res) > 0 {
		_, errLinkDriver := order.LinkOrderWithDriver(orderId, res[0].DriverID)
		if errLinkDriver != nil {
			return errLinkDriver
		}
		driver, errGetDriver := order.database.Driver.FindUnique(
			db.Driver.ID.Equals(res[0].DriverID),
		).With(
			db.Driver.DeviceToken.Fetch(),
		).Exec(context.Background())
		if errGetDriver != nil {
			return errGetDriver
		}
		deviceToken, okDeviceToke := driver.DeviceToken()
		if !okDeviceToke {
			return errors.New("seem driver don't have a device token")
		}

		message := &messaging.Message{
			Data: map[string]string{
				"title":   "Kamu mendapatkan tugas baru!",
				"message": "Klik untuk mendapatkan detail",
			},
			Token: deviceToken.Token,
		}
		errFrs := order.CreateOrderForDriver(driver.ID, orderId)
		if errFrs != nil {
			return errFrs
		}
		if _, err := order.messaging.Send(context.Background(), message); err != nil {
			return err
		}

		return nil
	}
	_, errUpdateOrder := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.Showable.Set(true),
	).Exec(context.Background())
	if errUpdateOrder != nil {
		return errUpdateOrder
	}
	return nil
}

func (order OrderService) LinkOrderWithDriver(orderId, driverId string) (*db.OrderModel, error) {
	linkDriver, errLinkDriver := order.database.Order.FindUnique(
		db.Order.ID.Equals(orderId),
	).Update(
		db.Order.Driver.Link(db.Driver.ID.Equals(driverId)),
	).Exec(context.Background())

	if errLinkDriver != nil {
		return nil, errLinkDriver
	}
	return linkDriver, nil
}

func (order OrderService) assignPtrStringIfTrue(value string, condition bool) *string {
	if condition {
		return &value
	}
	return nil
}

func (order OrderService) assignPtrTimeIfTrue(value time.Time, condition bool) *time.Time {
	if condition {
		return &value
	}
	return nil
}

func (order OrderService) driverSettings(orderType db.ServiceType, price int) string {
	if orderType == db.ServiceTypeBike {
		return fmt.Sprintf("AND driver_settings.ride_price <= %d AND driver_settings.ride = TRUE", price)
	}
	if orderType == db.ServiceTypeDelivery {
		return fmt.Sprintf("AND driver_settings.delivery_price <= %d AND driver_settings.delivery = TRUE", price)
	}
	if orderType == db.ServiceTypeFood {
		return fmt.Sprintf("AND driver_settings.food_price <= %d AND driver_settings.food = TRUE", price)
	}
	if orderType == db.ServiceTypeMart {
		return fmt.Sprintf("AND driver_settings.mart_price <= %d AND driver_settings.mart = TRUE", price)
	} else {
		return ""
	}
}

func (order OrderService) rejectedDriver(driverIds []string) string {
	if len(driverIds) < 2 && len(driverIds) != 0 {
		return fmt.Sprintf("AND driver.id NOT IN ('%s')", driverIds[0])
	}
	if len(driverIds) > 1 {
		return fmt.Sprintf("AND driver.id NOT IN ('%s')", strings.Join(driverIds, "','"))
	}
	return ""
}

func (order OrderService) getPreviousDay() time.Time {
	currentTime := time.Now()

	currentHour := currentTime.Hour()

	adjustedTime := currentTime.Add(-time.Duration(currentHour) * time.Hour)
	return adjustedTime
}

func (order OrderService) getNextDay() time.Time {
	currentTime := time.Now()

	currentHour := currentTime.Hour()

	adjustedTime := currentTime.Add(time.Duration(currentHour) * time.Hour)
	return adjustedTime
}

func (order OrderService) getPreviousWeek() time.Time {
	currentTime := time.Now()
	currentDay := currentTime.Day()

	previousWeek := currentTime.AddDate(0, 0, -7-currentDay)
	return previousWeek
}

func (order OrderService) getNextWeek() time.Time {
	currentTime := time.Now()
	currentDay := currentTime.Day()

	nextWeek := currentTime.AddDate(0, 0, 7-currentDay)
	return nextWeek
}

func (order OrderService) getPreviousMonth() time.Time {
	currentTime := time.Now()

	previousMonth := currentTime.AddDate(0, -1, 0)
	return previousMonth
}

func (order OrderService) getNextMonth() time.Time {
	currentTime := time.Now()

	nextMonth := currentTime.AddDate(0, 1, 0)
	return nextMonth
}
