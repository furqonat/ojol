-- CreateTable
CREATE TABLE "merchant_operation_time" (
    "id" TEXT NOT NULL,
    "day" TEXT NOT NULL,
    "open_time" TIMESTAMP(3) NOT NULL,
    "close_time" TIMESTAMP(3) NOT NULL,
    "merchant_details_id" TEXT,

    CONSTRAINT "merchant_operation_time_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "merchant_operation_time" ADD CONSTRAINT "merchant_operation_time_merchant_details_id_fkey" FOREIGN KEY ("merchant_details_id") REFERENCES "merchant_details"("id") ON DELETE SET NULL ON UPDATE CASCADE;
