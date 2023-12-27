/*
  Warnings:

  - You are about to drop the column `price_in_m` on the `services` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "services" DROP COLUMN "price_in_m",
ADD COLUMN     "price_in_km" INTEGER NOT NULL DEFAULT 0;
