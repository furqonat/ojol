-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_order_id_fkey";

-- CreateTable
CREATE TABLE "transaction_detail" (
    "id" TEXT NOT NULL,
    "transactions_id" TEXT NOT NULL,
    "checkout_url" TEXT NOT NULL,
    "acquirement_id" TEXT NOT NULL,
    "merchant_trans_id" TEXT NOT NULL,

    CONSTRAINT "transaction_detail_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "transaction_detail_transactions_id_key" ON "transaction_detail"("transactions_id");

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaction_detail" ADD CONSTRAINT "transaction_detail_transactions_id_fkey" FOREIGN KEY ("transactions_id") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
