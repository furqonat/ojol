/*
  Warnings:

  - Added the required column `driver_type` to the `driver_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "driver_details" ADD COLUMN     "driver_type" "vehicle_type" NOT NULL;
