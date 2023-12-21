-- AlterEnum
ALTER TYPE "service_type" ADD VALUE 'DELIVERY';

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL,
    "enable" BOOLEAN NOT NULL DEFAULT true,
    "service_type" "service_type" NOT NULL,

    CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);
