-- CreateTable
CREATE TABLE "order_detail" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "address" TEXT NOT NULL,
    "dst_latitude" DOUBLE PRECISION NOT NULL,
    "dst_longitude" DOUBLE PRECISION NOT NULL,
    "dst_address" TEXT NOT NULL,

    CONSTRAINT "order_detail_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "order_detail_order_id_key" ON "order_detail"("order_id");

-- AddForeignKey
ALTER TABLE "order_detail" ADD CONSTRAINT "order_detail_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "order"("id") ON DELETE CASCADE ON UPDATE CASCADE;
