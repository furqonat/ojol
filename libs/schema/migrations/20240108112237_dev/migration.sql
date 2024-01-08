/*
  Warnings:

  - You are about to alter the column `current_balance` on the `company_balance` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `balance_in` on the `company_balance` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `balance_out` on the `company_balance` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to drop the column `customer_id` on the `promotion` table. All the data in the column will be lost.
  - You are about to drop the column `driver_id` on the `promotion` table. All the data in the column will be lost.
  - You are about to drop the column `merchant_id` on the `promotion` table. All the data in the column will be lost.
  - Added the required column `app_type` to the `promotion` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "app_type" AS ENUM ('CUSTOMER', 'DRIVER', 'MERCHANT');

-- DropForeignKey
ALTER TABLE "promotion" DROP CONSTRAINT "promotion_customer_id_fkey";

-- DropForeignKey
ALTER TABLE "promotion" DROP CONSTRAINT "promotion_driver_id_fkey";

-- DropForeignKey
ALTER TABLE "promotion" DROP CONSTRAINT "promotion_merchant_id_fkey";

-- AlterTable
ALTER TABLE "company_balance" ALTER COLUMN "current_balance" SET DATA TYPE INTEGER,
ALTER COLUMN "balance_in" SET DATA TYPE INTEGER,
ALTER COLUMN "balance_out" SET DATA TYPE INTEGER;

-- AlterTable
ALTER TABLE "promotion" DROP COLUMN "customer_id",
DROP COLUMN "driver_id",
DROP COLUMN "merchant_id",
ADD COLUMN     "app_type" "app_type" NOT NULL;
