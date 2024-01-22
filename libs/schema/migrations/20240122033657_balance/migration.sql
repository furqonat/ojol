/*
  Warnings:

  - Added the required column `balanceBeforeFee` to the `company_balance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `balanceBeforeKorcabFee` to the `company_balance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `balanceDriverBonus` to the `company_balance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "company_balance" ADD COLUMN     "balanceBeforeFee" INTEGER NOT NULL,
ADD COLUMN     "balanceBeforeKorcabFee" INTEGER NOT NULL,
ADD COLUMN     "balanceDriverBonus" INTEGER NOT NULL;
