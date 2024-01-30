-- CreateTable
CREATE TABLE "verification" (
    "id" TEXT NOT NULL,
    "code" INTEGER NOT NULL,
    "phone" TEXT NOT NULL,
    "verified_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "verification_pkey" PRIMARY KEY ("id")
);
