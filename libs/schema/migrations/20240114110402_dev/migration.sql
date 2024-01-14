/*
  Warnings:

  - A unique constraint covering the columns `[customer_id]` on the table `dana_token` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[driver_id]` on the table `dana_token_driver` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[merchant_id]` on the table `dana_token_merchant` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "dana_token_customer_id_key" ON "dana_token"("customer_id");

-- CreateIndex
CREATE UNIQUE INDEX "dana_token_driver_driver_id_key" ON "dana_token_driver"("driver_id");

-- CreateIndex
CREATE UNIQUE INDEX "dana_token_merchant_merchant_id_key" ON "dana_token_merchant"("merchant_id");
