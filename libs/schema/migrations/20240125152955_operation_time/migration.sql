-- AlterTable
ALTER TABLE "bonus_driver" ADD COLUMN     "paid" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "merchant_operation_time" ALTER COLUMN "open_time" SET DATA TYPE TEXT,
ALTER COLUMN "close_time" SET DATA TYPE TEXT;
