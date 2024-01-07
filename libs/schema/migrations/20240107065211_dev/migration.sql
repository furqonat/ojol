-- DropForeignKey
ALTER TABLE "images" DROP CONSTRAINT "images_merchant_details_id_fkey";

-- DropForeignKey
ALTER TABLE "merchant_operation_time" DROP CONSTRAINT "merchant_operation_time_merchant_details_id_fkey";

-- AddForeignKey
ALTER TABLE "merchant_operation_time" ADD CONSTRAINT "merchant_operation_time_merchant_details_id_fkey" FOREIGN KEY ("merchant_details_id") REFERENCES "merchant_details"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "images" ADD CONSTRAINT "images_merchant_details_id_fkey" FOREIGN KEY ("merchant_details_id") REFERENCES "merchant_details"("id") ON DELETE CASCADE ON UPDATE CASCADE;
