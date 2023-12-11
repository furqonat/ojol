-- CreateEnum
CREATE TYPE "customer_status" AS ENUM ('ACTIVE', 'LOCK', 'BLOCK');

-- CreateEnum
CREATE TYPE "driver_badge" AS ENUM ('BASIC', 'REGULAR', 'PREMIUM');

-- CreateEnum
CREATE TYPE "driver_status" AS ENUM ('ACTIVE', 'PROCESS', 'BLOCK');

-- CreateEnum
CREATE TYPE "vehicle_type" AS ENUM ('CAR', 'BIKE');

-- CreateEnum
CREATE TYPE "merchant_badge" AS ENUM ('BASIC', 'REGULAR', 'PREMIUM');

-- CreateEnum
CREATE TYPE "merchant_status" AS ENUM ('ACTIVE', 'PROCESS', 'BLOCK');

-- CreateEnum
CREATE TYPE "merchant_type" AS ENUM ('FOOD', 'MART');

-- CreateTable
CREATE TABLE "customer" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "password" TEXT,
    "last_sign_in" TIMESTAMP(3),
    "last_active" TIMESTAMP(3),
    "email_verified" BOOLEAN NOT NULL DEFAULT false,
    "phone_verified" BOOLEAN NOT NULL DEFAULT false,
    "avatar" TEXT,
    "status" "customer_status" NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT "customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_device_token" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "customer_id" TEXT,

    CONSTRAINT "customer_device_token_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "password" TEXT,
    "last_sign_in" TIMESTAMP(3),
    "last_active" TIMESTAMP(3),
    "email_verified" BOOLEAN NOT NULL DEFAULT false,
    "phone_verified" BOOLEAN NOT NULL DEFAULT false,
    "avatar" TEXT,
    "status" "driver_status" NOT NULL DEFAULT 'PROCESS',

    CONSTRAINT "driver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver_settings" (
    "id" TEXT NOT NULL,
    "driver_id" TEXT NOT NULL,
    "ride" BOOLEAN NOT NULL DEFAULT true,
    "ride_price" INTEGER NOT NULL DEFAULT 0,
    "delivery" BOOLEAN NOT NULL DEFAULT true,
    "delevery_price" INTEGER NOT NULL DEFAULT 0,
    "food" BOOLEAN NOT NULL DEFAULT true,
    "food_price" INTEGER NOT NULL DEFAULT 0,
    "mart" BOOLEAN NOT NULL DEFAULT true,
    "mart_price" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "driver_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver_details" (
    "id" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "driver_id" TEXT,
    "license_image" TEXT NOT NULL,
    "id_card_image" TEXT NOT NULL,
    "current_lat" DOUBLE PRECISION,
    "current_lng" DOUBLE PRECISION,
    "badge" "driver_badge" NOT NULL DEFAULT 'BASIC',

    CONSTRAINT "driver_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicle" (
    "id" TEXT NOT NULL,
    "vehicle_type" "vehicle_type" NOT NULL,
    "driver_details_id" TEXT,
    "vehicle_brand" TEXT NOT NULL,
    "vehicle_year" TEXT NOT NULL,
    "vehicle_image" TEXT NOT NULL,
    "vehicle_registration" TEXT NOT NULL,

    CONSTRAINT "vehicle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver_device_token" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "driver_id" TEXT,

    CONSTRAINT "driver_device_token_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchant" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "password" TEXT,
    "last_sign_in" TIMESTAMP(3),
    "last_active" TIMESTAMP(3),
    "email_verified" BOOLEAN NOT NULL DEFAULT false,
    "phone_verified" BOOLEAN NOT NULL DEFAULT false,
    "avatar" TEXT,
    "status" "merchant_status" NOT NULL DEFAULT 'PROCESS',

    CONSTRAINT "merchant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchant_details" (
    "id" TEXT NOT NULL,
    "merchant_id" TEXT,
    "id_card_image" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "name" TEXT NOT NULL,
    "badge" "merchant_badge" NOT NULL DEFAULT 'BASIC',

    CONSTRAINT "merchant_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "images" (
    "id" TEXT NOT NULL,
    "merchant_details_id" TEXT NOT NULL,
    "link" TEXT NOT NULL,

    CONSTRAINT "images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchant_device_token" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "merchant_id" TEXT,

    CONSTRAINT "merchant_device_token_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "last_sign_in" TIMESTAMP(3),
    "status" BOOLEAN NOT NULL DEFAULT true,
    "avatar" TEXT,

    CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_adminToroles" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "customer_device_token_token_key" ON "customer_device_token"("token");

-- CreateIndex
CREATE UNIQUE INDEX "driver_settings_driver_id_key" ON "driver_settings"("driver_id");

-- CreateIndex
CREATE UNIQUE INDEX "driver_details_driver_id_key" ON "driver_details"("driver_id");

-- CreateIndex
CREATE UNIQUE INDEX "vehicle_driver_details_id_key" ON "vehicle"("driver_details_id");

-- CreateIndex
CREATE UNIQUE INDEX "driver_device_token_token_key" ON "driver_device_token"("token");

-- CreateIndex
CREATE UNIQUE INDEX "merchant_details_merchant_id_key" ON "merchant_details"("merchant_id");

-- CreateIndex
CREATE UNIQUE INDEX "merchant_device_token_token_key" ON "merchant_device_token"("token");

-- CreateIndex
CREATE UNIQUE INDEX "admin_email_key" ON "admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_adminToroles_AB_unique" ON "_adminToroles"("A", "B");

-- CreateIndex
CREATE INDEX "_adminToroles_B_index" ON "_adminToroles"("B");

-- AddForeignKey
ALTER TABLE "customer_device_token" ADD CONSTRAINT "customer_device_token_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_settings" ADD CONSTRAINT "driver_settings_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_details" ADD CONSTRAINT "driver_details_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle" ADD CONSTRAINT "vehicle_driver_details_id_fkey" FOREIGN KEY ("driver_details_id") REFERENCES "driver_details"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_device_token" ADD CONSTRAINT "driver_device_token_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merchant_details" ADD CONSTRAINT "merchant_details_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "images" ADD CONSTRAINT "images_merchant_details_id_fkey" FOREIGN KEY ("merchant_details_id") REFERENCES "merchant_details"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merchant_device_token" ADD CONSTRAINT "merchant_device_token_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_adminToroles" ADD CONSTRAINT "_adminToroles_A_fkey" FOREIGN KEY ("A") REFERENCES "admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_adminToroles" ADD CONSTRAINT "_adminToroles_B_fkey" FOREIGN KEY ("B") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
