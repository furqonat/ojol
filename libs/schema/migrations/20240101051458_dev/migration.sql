-- CreateEnum
CREATE TYPE "position" AS ENUM ('TOP', 'BOTTOM');

-- CreateTable
CREATE TABLE "settings" (
    "id" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "sk" TEXT,
    "slug" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sk_for" "applied_for" NOT NULL,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "banner" (
    "id" TEXT NOT NULL,
    "position" "position" NOT NULL DEFAULT 'TOP',
    "url" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "banner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "banner_images" (
    "id" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "banner_id" TEXT,

    CONSTRAINT "banner_images_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "banner_images" ADD CONSTRAINT "banner_images_banner_id_fkey" FOREIGN KEY ("banner_id") REFERENCES "banner"("id") ON DELETE SET NULL ON UPDATE CASCADE;
