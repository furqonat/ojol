package services

import (
	"apps/transactions/db"
	"apps/transactions/utils"
	"context"
)

type TscService struct {
	database utils.Database
	logger   utils.Logger
}

func NewTscService(database utils.Database, logger utils.Logger) *TscService {
	return &TscService{
		database: database,
		logger:   logger,
	}
}

func (t TscService) CreateTransaction(model *db.TransactionsModel) (*db.TransactionsModel, error) {
	f, er := t.database.Transactions.CreateOne(
		db.Transactions.Type.Set(model.Type),
		db.Transactions.PaymentType.Set(model.PaymentType),
		db.Transactions.Order.Link(db.Order.ID.Equals(model.OrderID)),
		db.Transactions.Status.Set(db.TransactionStatusCreated),
	).Exec(context.Background())
	if er != nil {
		return nil, er
	}
	return f, nil
}

func (t TscService) GetTransactions(take int, skip int) ([]db.TransactionsModel, error) {
	transactions, err := t.database.Transactions.FindMany().With(db.Transactions.Order.Fetch()).Take(take).Skip(skip).OrderBy(db.Transactions.EndedAt.Order(db.SortOrderDesc)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return transactions, nil
}

func (t TscService) GetTransaction(id string) (*db.TransactionsModel, error) {
	trx, err := t.database.Transactions.FindUnique(db.Transactions.ID.Equals(id)).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return trx, nil
}

func (t TscService) UpdateTransaction(id string, model *db.TransactionsModel) (*db.TransactionsModel, error) {
	acceptedAt, _ := model.AcceptedAt()
	shippingAt, _ := model.ShippingAt()
	deliveredAt, _ := model.DeliveredAt()
	endedAt, _ := model.DeliveredAt()
	paymentAt, _ := model.PaymentAt()
	trx, err := t.database.Transactions.FindUnique(
		db.Transactions.ID.Equals(id),
	).Update(
		db.Transactions.Status.SetIfPresent(&model.Status),
		db.Transactions.AcceptedAt.SetOptional(&acceptedAt),
		db.Transactions.PaymentAt.SetOptional(&paymentAt),
		db.Transactions.ShippingAt.SetOptional(&shippingAt),
		db.Transactions.DeliveredAt.SetOptional(&deliveredAt),
		db.Transactions.EndedAt.SetOptional(&endedAt),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return trx, nil
}
