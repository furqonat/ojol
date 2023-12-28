/*
  Warnings:

  - Added the required column `vehicle_rn` to the `vehicle` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "vehicle" ADD COLUMN     "vehicle_rn" TEXT NOT NULL;
