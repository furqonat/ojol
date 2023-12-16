-- AlterTable
ALTER TABLE "product" ADD COLUMN     "image" TEXT,
ADD COLUMN     "product_type" "merchant_type" NOT NULL DEFAULT 'FOOD';

-- CreateTable
CREATE TABLE "category" (
    "id" TEXT NOT NULL,
    "product_id" TEXT,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "category" ADD CONSTRAINT "category_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE SET NULL ON UPDATE CASCADE;
