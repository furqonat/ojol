-- AlterTable
ALTER TABLE "driver_settings" ADD COLUMN     "auto_bid" BOOLEAN NOT NULL DEFAULT true;

-- CreateTable
CREATE TABLE "order_rejected" (
    "id" TEXT NOT NULL,
    "order_id" TEXT,
    "driver_id" TEXT,

    CONSTRAINT "order_rejected_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "order_rejected" ADD CONSTRAINT "order_rejected_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_rejected" ADD CONSTRAINT "order_rejected_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "driver"("id") ON DELETE CASCADE ON UPDATE CASCADE;
