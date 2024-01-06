-- AlterTable
ALTER TABLE "driver" ADD COLUMN     "referal_id" TEXT;

-- CreateTable
CREATE TABLE "referal" (
    "id" TEXT NOT NULL,
    "admin_id" TEXT NOT NULL,
    "ref" TEXT NOT NULL,

    CONSTRAINT "referal_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "referal_admin_id_key" ON "referal"("admin_id");

-- AddForeignKey
ALTER TABLE "driver" ADD CONSTRAINT "driver_referal_id_fkey" FOREIGN KEY ("referal_id") REFERENCES "referal"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "referal" ADD CONSTRAINT "referal_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;
