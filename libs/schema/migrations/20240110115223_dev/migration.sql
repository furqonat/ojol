/*
  Warnings:

  - You are about to drop the column `bank_holder` on the `admin` table. All the data in the column will be lost.
  - You are about to drop the column `bank_name` on the `admin` table. All the data in the column will be lost.
  - You are about to drop the column `bank_number` on the `admin` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "admin" DROP COLUMN "bank_holder",
DROP COLUMN "bank_name",
DROP COLUMN "bank_number";
