/*
  Warnings:

  - The values [WAITING_PAYMENT,ACCEPTED,SHIPPING,DELIVERED,CANCELED] on the enum `transaction_status` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `cart_id` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `merchant_id` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `product_id` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `favorites_id` on the `product` table. All the data in the column will be lost.
  - You are about to drop the `customer_merchant_review` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `product_id` to the `favorites` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gross_amount` to the `order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `net_amount` to the `order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `shipping_cost` to the `order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_amount` to the `order` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "order_status" AS ENUM ('CREATED', 'WAITING_PAYMENT', 'PAID', 'CANCELED', 'PROCESS', 'ACCEPTED', 'SHIPPING', 'DELIVERED', 'DONE');

-- AlterEnum
BEGIN;
CREATE TYPE "transaction_status_new" AS ENUM ('CREATED', 'PROCESS', 'PAID', 'REFUND', 'DONE');
ALTER TABLE "transactions" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "transactions" ALTER COLUMN "status" TYPE "transaction_status_new" USING ("status"::text::"transaction_status_new");
ALTER TYPE "transaction_status" RENAME TO "transaction_status_old";
ALTER TYPE "transaction_status_new" RENAME TO "transaction_status";
DROP TYPE "transaction_status_old";
ALTER TABLE "transactions" ALTER COLUMN "status" SET DEFAULT 'CREATED';
COMMIT;

-- DropForeignKey
ALTER TABLE "customer_merchant_review" DROP CONSTRAINT "customer_merchant_review_customer_id_fkey";

-- DropForeignKey
ALTER TABLE "customer_merchant_review" DROP CONSTRAINT "customer_merchant_review_merchant_id_fkey";

-- DropForeignKey
ALTER TABLE "customer_merchant_review" DROP CONSTRAINT "customer_merchant_review_transacrions_id_fkey";

-- DropForeignKey
ALTER TABLE "driver_settings" DROP CONSTRAINT "driver_settings_driver_id_fkey";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "order_cart_id_fkey";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "order_merchant_id_fkey";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "order_product_id_fkey";

-- DropForeignKey
ALTER TABLE "product" DROP CONSTRAINT "product_favorites_id_fkey";

-- DropIndex
DROP INDEX "order_cart_id_key";

-- AlterTable
ALTER TABLE "favorites" ADD COLUMN     "product_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "order" DROP COLUMN "cart_id",
DROP COLUMN "merchant_id",
DROP COLUMN "product_id",
ADD COLUMN     "discount_id" TEXT,
ADD COLUMN     "gross_amount" INTEGER NOT NULL,
ADD COLUMN     "net_amount" INTEGER NOT NULL,
ADD COLUMN     "order_status" "order_status" NOT NULL DEFAULT 'CREATED',
ADD COLUMN     "shipping_cost" INTEGER NOT NULL,
ADD COLUMN     "tax_id" TEXT,
ADD COLUMN     "total_amount" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "product" DROP COLUMN "favorites_id",
ALTER COLUMN "status" SET DEFAULT true;

-- DropTable
DROP TABLE "customer_merchant_review";

-- CreateTable
CREATE TABLE "driver_wallet" (
    "id" TEXT NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "driver_id" TEXT,

    CONSTRAINT "driver_wallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shipping_cost" (
    "id" TEXT NOT NULL,
    "cost" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "shipping_cost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_item" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "order_id" TEXT,

    CONSTRAINT "order_item_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "driver_wallet_driver_id_key" ON "driver_wallet"("driver_id");

-- AddForeignKey
ALTER TABLE "driver_settings" ADD CONSTRAINT "driver_settings_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_wallet" ADD CONSTRAINT "driver_wallet_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "discount"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_tax_id_fkey" FOREIGN KEY ("tax_id") REFERENCES "tax"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_item" ADD CONSTRAINT "order_item_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_item" ADD CONSTRAINT "order_item_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order"("id") ON DELETE SET NULL ON UPDATE CASCADE;
