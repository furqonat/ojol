-- CreateEnum
CREATE TYPE "transaction_type" AS ENUM ('FOOD', 'MART', 'CAR', 'BIKE', 'DELIVERY');

-- CreateEnum
CREATE TYPE "transaction_status" AS ENUM ('CREATED', 'WAITING_PAYMENT', 'PROCESS', 'ACCEPTED', 'SHIPPING', 'DELIVERED', 'DONE');

-- CreateEnum
CREATE TYPE "payment_type" AS ENUM ('CASH', 'DANA', 'OTHER');

-- CreateTable
CREATE TABLE "product" (
    "id" TEXT NOT NULL,
    "merchant_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "price" BIGINT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "cart_id" TEXT NOT NULL,
    "favorites_id" TEXT,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "favorites" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,

    CONSTRAINT "favorites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_product_review" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "review" TEXT,
    "rating" INTEGER NOT NULL,
    "createdt_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transacrions_id" TEXT NOT NULL,

    CONSTRAINT "customer_product_review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_merchant_review" (
    "id" TEXT NOT NULL,
    "review" TEXT,
    "rating" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "merchant_id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "transacrions_id" TEXT NOT NULL,

    CONSTRAINT "customer_merchant_review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_driver_review" (
    "id" TEXT NOT NULL,
    "review" TEXT,
    "rating" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "driver_id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "transacrions_id" TEXT NOT NULL,

    CONSTRAINT "customer_driver_review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver_customer_review" (
    "id" TEXT NOT NULL,
    "review" TEXT,
    "rating" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "driver_id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "transacrions_id" TEXT NOT NULL,

    CONSTRAINT "driver_customer_review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order" (
    "id" TEXT NOT NULL,
    "order_type" "transaction_type" NOT NULL,
    "order_status" "transaction_status" NOT NULL DEFAULT 'CREATED',
    "driver_id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "merchant_id" TEXT,
    "product_id" TEXT,

    CONSTRAINT "order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cart" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" TEXT NOT NULL,
    "type" "transaction_type" NOT NULL,
    "status" "transaction_status" NOT NULL DEFAULT 'CREATED',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payment_at" TIMESTAMP(3),
    "accepted_at" TIMESTAMP(3),
    "shipping_at" TIMESTAMP(3),
    "delivered_at" TIMESTAMP(3),
    "ended_at" TIMESTAMP(3),
    "payment_type" "payment_type" NOT NULL,
    "order_id" TEXT NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "transactions_order_id_key" ON "transactions"("order_id");

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_cart_id_fkey" FOREIGN KEY ("cart_id") REFERENCES "cart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_favorites_id_fkey" FOREIGN KEY ("favorites_id") REFERENCES "favorites"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_product_review" ADD CONSTRAINT "customer_product_review_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_product_review" ADD CONSTRAINT "customer_product_review_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_product_review" ADD CONSTRAINT "customer_product_review_transacrions_id_fkey" FOREIGN KEY ("transacrions_id") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_merchant_review" ADD CONSTRAINT "customer_merchant_review_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_merchant_review" ADD CONSTRAINT "customer_merchant_review_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_merchant_review" ADD CONSTRAINT "customer_merchant_review_transacrions_id_fkey" FOREIGN KEY ("transacrions_id") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_driver_review" ADD CONSTRAINT "customer_driver_review_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_driver_review" ADD CONSTRAINT "customer_driver_review_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_driver_review" ADD CONSTRAINT "customer_driver_review_transacrions_id_fkey" FOREIGN KEY ("transacrions_id") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_customer_review" ADD CONSTRAINT "driver_customer_review_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_customer_review" ADD CONSTRAINT "driver_customer_review_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_customer_review" ADD CONSTRAINT "driver_customer_review_transacrions_id_fkey" FOREIGN KEY ("transacrions_id") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_merchant_id_fkey" FOREIGN KEY ("merchant_id") REFERENCES "merchant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
