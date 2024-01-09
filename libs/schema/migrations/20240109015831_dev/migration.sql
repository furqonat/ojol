/*
  Warnings:

  - Added the required column `amount` to the `driver_trx` table without a default value. This is not possible if the table is not empty.
  - Added the required column `amount` to the `merchant_trx` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "trx_type" ADD VALUE 'ADJUSTMENT';

-- AlterTable
ALTER TABLE "driver_trx" ADD COLUMN     "amount" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "merchant_trx" ADD COLUMN     "amount" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "trx_admin" (
    "id" TEXT NOT NULL,
    "trx_type" "trx_type" NOT NULL,
    "amount" INTEGER NOT NULL,
    "note" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "admin_id" TEXT NOT NULL,

    CONSTRAINT "trx_admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trx_company" (
    "id" TEXT NOT NULL,
    "trx_type" "trx_type" NOT NULL,
    "amount" INTEGER NOT NULL,
    "note" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "trx_company_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "trx_admin" ADD CONSTRAINT "trx_admin_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
