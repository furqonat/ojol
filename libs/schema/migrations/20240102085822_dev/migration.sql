-- CreateEnum
CREATE TYPE "trx_status" AS ENUM ('CREATED', 'PROCESS', 'SUCCESS');

-- CreateEnum
CREATE TYPE "trx_type" AS ENUM ('TOPUP', 'WITHDRAW');

-- CreateTable
CREATE TABLE "driver_trx" (
    "id" TEXT NOT NULL,
    "trx_type" "trx_type" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payment_at" TIMESTAMP(3),
    "status" "trx_status" NOT NULL DEFAULT 'CREATED',
    "driver_id" TEXT NOT NULL,

    CONSTRAINT "driver_trx_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchant_trx" (
    "id" TEXT NOT NULL,
    "trx_type" "trx_type" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payment_at" TIMESTAMP(3),
    "status" "trx_status" NOT NULL DEFAULT 'CREATED',
    "merchant_id" TEXT NOT NULL,

    CONSTRAINT "merchant_trx_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchant_wallet" (
    "id" TEXT NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "merchant_id" TEXT NOT NULL,

    CONSTRAINT "merchant_wallet_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "merchant_wallet_merchant_id_key" ON "merchant_wallet"("merchant_id");

-- AddForeignKey
ALTER TABLE "driver_trx" ADD CONSTRAINT "driver_trx_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merchant_trx" ADD CONSTRAINT "merchant_trx_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merchant_wallet" ADD CONSTRAINT "merchant_wallet_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
