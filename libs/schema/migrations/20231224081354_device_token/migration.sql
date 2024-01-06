/*
  Warnings:

  - A unique constraint covering the columns `[customer_id]` on the table `customer_device_token` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[driver_id]` on the table `driver_device_token` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[merchant_id]` on the table `merchant_device_token` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "driver_device_token_token_key";

-- CreateIndex
CREATE UNIQUE INDEX "customer_device_token_customer_id_key" ON "customer_device_token"("customer_id");

-- CreateIndex
CREATE UNIQUE INDEX "driver_device_token_driver_id_key" ON "driver_device_token"("driver_id");

-- CreateIndex
CREATE UNIQUE INDEX "merchant_device_token_merchant_id_key" ON "merchant_device_token"("merchant_id");
