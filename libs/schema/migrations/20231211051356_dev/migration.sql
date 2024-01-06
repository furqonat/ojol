/*
  Warnings:

  - You are about to drop the column `payment_type` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `payment_type` to the `order` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "order" ADD COLUMN     "payment_type" "payment_type" NOT NULL;

-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "payment_type";
