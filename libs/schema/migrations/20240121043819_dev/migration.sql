/*
  Warnings:

  - Added the required column `trx_from` to the `trx_company` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "trx_company_type" AS ENUM ('DRIVER', 'MERCHANT', 'ADMIN');

-- DropForeignKey
ALTER TABLE "trx_admin" DROP CONSTRAINT "trx_admin_admin_id_fkey";

-- AlterTable
ALTER TABLE "trx_admin" ALTER COLUMN "admin_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "trx_company" ADD COLUMN     "trx_from" "trx_company_type" NOT NULL;

-- CreateTable
CREATE TABLE "bonus_driver" (
    "id" TEXT NOT NULL,
    "driver_id" TEXT,
    "order_id" TEXT,
    "trx_type" "service_type" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "bonus_driver_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "bonus_driver_order_id_key" ON "bonus_driver"("order_id");

-- AddForeignKey
ALTER TABLE "trx_admin" ADD CONSTRAINT "trx_admin_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_driver" ADD CONSTRAINT "bonus_driver_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bonus_driver" ADD CONSTRAINT "bonus_driver_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order"("id") ON DELETE SET NULL ON UPDATE CASCADE;
