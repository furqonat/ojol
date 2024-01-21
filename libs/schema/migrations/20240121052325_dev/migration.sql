/*
  Warnings:

  - Added the required column `amount` to the `bonus_driver` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "bonus_driver" ADD COLUMN     "amount" INTEGER NOT NULL;
