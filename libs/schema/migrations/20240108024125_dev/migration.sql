-- CreateEnum
CREATE TYPE "admin_type" AS ENUM ('KORLAP', 'KORCAP');

-- CreateTable
CREATE TABLE "admin_wallet" (
    "id" TEXT NOT NULL,
    "admin_id" TEXT NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "update_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "admin_wallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "korlap_fee" (
    "id" TEXT NOT NULL,
    "admin_type" "admin_type" NOT NULL,
    "percentage" INTEGER NOT NULL,

    CONSTRAINT "korlap_fee_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "admin_wallet_admin_id_key" ON "admin_wallet"("admin_id");

-- AddForeignKey
ALTER TABLE "admin_wallet" ADD CONSTRAINT "admin_wallet_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;
