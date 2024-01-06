/*
  Warnings:

  - You are about to drop the column `delevery_price` on the `driver_settings` table. All the data in the column will be lost.
  - Changed the type of `order_type` on the `order` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `type` on the `transactions` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "transaction_detail" DROP CONSTRAINT "transaction_detail_transactions_id_fkey";

-- AlterTable
ALTER TABLE "driver_settings" DROP COLUMN "delevery_price",
ADD COLUMN     "delivery_price" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "order" DROP COLUMN "order_type",
ADD COLUMN     "order_type" "service_type" NOT NULL;

-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "type",
ADD COLUMN     "type" "service_type" NOT NULL;

-- DropEnum
DROP TYPE "transaction_type";

-- AddForeignKey
ALTER TABLE "transaction_detail" ADD CONSTRAINT "transaction_detail_transactions_id_fkey" FOREIGN KEY ("transactions_id") REFERENCES "transactions"("id") ON DELETE CASCADE ON UPDATE CASCADE;
