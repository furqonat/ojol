/*
  Warnings:

  - The values [KORCAP] on the enum `admin_type` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "admin_type_new" AS ENUM ('KORLAP', 'KORCAB');
ALTER TABLE "korlap_fee" ALTER COLUMN "admin_type" TYPE "admin_type_new" USING ("admin_type"::text::"admin_type_new");
ALTER TYPE "admin_type" RENAME TO "admin_type_old";
ALTER TYPE "admin_type_new" RENAME TO "admin_type";
DROP TYPE "admin_type_old";
COMMIT;
