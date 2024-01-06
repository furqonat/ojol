/*
  Warnings:

  - You are about to drop the column `price_in_km` on the `services` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "services" DROP COLUMN "price_in_km",
ADD COLUMN     "price_in_m" INTEGER NOT NULL DEFAULT 0;
