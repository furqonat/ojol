/*
  Warnings:

  - You are about to drop the column `balanceBeforeFee` on the `company_balance` table. All the data in the column will be lost.
  - You are about to drop the column `balanceBeforeKorcabFee` on the `company_balance` table. All the data in the column will be lost.
  - You are about to drop the column `balanceDriverBonus` on the `company_balance` table. All the data in the column will be lost.
  - Added the required column `balance_before_fee` to the `company_balance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `balance_before_korcab_fee` to the `company_balance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `balance_driver_bonus` to the `company_balance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "company_balance" DROP COLUMN "balanceBeforeFee",
DROP COLUMN "balanceBeforeKorcabFee",
DROP COLUMN "balanceDriverBonus",
ADD COLUMN     "balance_before_fee" INTEGER NOT NULL,
ADD COLUMN     "balance_before_korcab_fee" INTEGER NOT NULL,
ADD COLUMN     "balance_driver_bonus" INTEGER NOT NULL;
