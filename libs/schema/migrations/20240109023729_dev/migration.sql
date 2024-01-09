-- CreateTable
CREATE TABLE "dana_token_driver" (
    "id" TEXT NOT NULL,
    "access_token" TEXT NOT NULL,
    "expires_in" TIMESTAMP(3) NOT NULL,
    "refresh_token" TEXT NOT NULL,
    "re_expires_in" TIMESTAMP(3) NOT NULL,
    "token_status" TEXT NOT NULL,
    "dana_user_id" TEXT NOT NULL,
    "driver_id" TEXT NOT NULL,

    CONSTRAINT "dana_token_driver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dana_token_merchant" (
    "id" TEXT NOT NULL,
    "access_token" TEXT NOT NULL,
    "expires_in" TIMESTAMP(3) NOT NULL,
    "refresh_token" TEXT NOT NULL,
    "re_expires_in" TIMESTAMP(3) NOT NULL,
    "token_status" TEXT NOT NULL,
    "dana_user_id" TEXT NOT NULL,
    "merchant_id" TEXT NOT NULL,

    CONSTRAINT "dana_token_merchant_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "dana_token_driver" ADD CONSTRAINT "dana_token_driver_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dana_token_merchant" ADD CONSTRAINT "dana_token_merchant_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
