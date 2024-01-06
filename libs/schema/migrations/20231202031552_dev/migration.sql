/*
  Warnings:

  - The `badge` column on the `driver_details` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `badge` column on the `merchant_details` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "badge" AS ENUM ('BASIC', 'REGULAR', 'PREMIUM');

-- CreateEnum
CREATE TYPE "tax_type" AS ENUM ('PPH', 'PPN');

-- CreateEnum
CREATE TYPE "applied_for" AS ENUM ('USER', 'DRIVER', 'MERCHANT', 'COMPANY');

-- CreateEnum
CREATE TYPE "balance_status" AS ENUM ('PENDING', 'PROCESS', 'DONE');

-- CreateEnum
CREATE TYPE "balance_type" AS ENUM ('IN', 'OUT');

-- CreateEnum
CREATE TYPE "service_type" AS ENUM ('BIKE', 'CAR', 'FOOD', 'MART');

-- AlterTable
ALTER TABLE "driver_details" DROP COLUMN "badge",
ADD COLUMN     "badge" "badge" NOT NULL DEFAULT 'BASIC';

-- AlterTable
ALTER TABLE "merchant_details" DROP COLUMN "badge",
ADD COLUMN     "badge" "badge" NOT NULL DEFAULT 'BASIC';

-- DropEnum
DROP TYPE "driver_badge";

-- DropEnum
DROP TYPE "merchant_badge";

-- CreateTable
CREATE TABLE "service_fee" (
    "id" TEXT NOT NULL,
    "service_type" "service_type" NOT NULL,
    "percentage" INTEGER NOT NULL,
    "account_type" "badge" NOT NULL,

    CONSTRAINT "service_fee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_balance" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "remark" TEXT,
    "current_balance" BIGINT NOT NULL,
    "balance_in" BIGINT NOT NULL,
    "balance_out" BIGINT NOT NULL,
    "type" "balance_type" NOT NULL,
    "status" "balance_status" NOT NULL,

    CONSTRAINT "company_balance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "discount" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "expired_at" TIMESTAMP(3),
    "status" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "percentage" INTEGER,
    "max_discount" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "min_transaction" INTEGER NOT NULL,

    CONSTRAINT "discount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tax" (
    "id" TEXT NOT NULL,
    "applied_for" "applied_for" NOT NULL,
    "tax_type" "tax_type" NOT NULL,
    "amount" INTEGER NOT NULL,
    "is_percent" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "tax_pkey" PRIMARY KEY ("id")
);
