/*
  Warnings:

  - You are about to drop the column `balance_in` on the `company_balance` table. All the data in the column will be lost.
  - You are about to drop the column `balance_out` on the `company_balance` table. All the data in the column will be lost.
  - You are about to drop the column `current_balance` on the `company_balance` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `company_balance` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `company_balance` table. All the data in the column will be lost.
  - Added the required column `balance` to the `company_balance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "trx_type" ADD VALUE 'REDUCTION';

-- AlterTable
ALTER TABLE "company_balance" DROP COLUMN "balance_in",
DROP COLUMN "balance_out",
DROP COLUMN "current_balance",
DROP COLUMN "status",
DROP COLUMN "type",
ADD COLUMN     "balance" INTEGER NOT NULL;
