/*
  Warnings:

  - Added the required column `trx_type` to the `discount` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "discount" ADD COLUMN     "trx_type" "service_type" NOT NULL;
