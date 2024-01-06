/*
  Warnings:

  - A unique constraint covering the columns `[cart_id]` on the table `order` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "order" ADD COLUMN     "cart_id" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "order_cart_id_key" ON "order"("cart_id");

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_cart_id_fkey" FOREIGN KEY ("cart_id") REFERENCES "cart"("id") ON DELETE CASCADE ON UPDATE CASCADE;
