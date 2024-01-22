/*
  Warnings:

  - You are about to drop the `company_balance` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterEnum
ALTER TYPE "trx_company_type" ADD VALUE 'BONUS_DRIVER';

-- DropTable
DROP TABLE "company_balance";
