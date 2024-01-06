/*
  Warnings:

  - A unique constraint covering the columns `[email]` on the table `driver` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[phone]` on the table `driver` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
ALTER TYPE "driver_status" ADD VALUE 'REJECT';

-- AlterEnum
ALTER TYPE "merchant_status" ADD VALUE 'REJECT';

-- CreateIndex
CREATE UNIQUE INDEX "driver_email_key" ON "driver"("email");

-- CreateIndex
CREATE UNIQUE INDEX "driver_phone_key" ON "driver"("phone");
