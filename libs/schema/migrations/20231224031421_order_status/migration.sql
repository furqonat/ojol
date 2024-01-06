/*
  Warnings:

  - The values [WAITING_PAYMENT,PAID,PROCESS,ACCEPTED,SHIPPING,DELIVERED,EXPIRED] on the enum `order_status` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "order_status_new" AS ENUM ('CREATED', 'FIND_DRIVER', 'DRIVER_OTW', 'DRIVER_CLOSE', 'OTW', 'DONE', 'CANCELED');
ALTER TABLE "order" ALTER COLUMN "order_status" DROP DEFAULT;
ALTER TABLE "order" ALTER COLUMN "order_status" TYPE "order_status_new" USING ("order_status"::text::"order_status_new");
ALTER TYPE "order_status" RENAME TO "order_status_old";
ALTER TYPE "order_status_new" RENAME TO "order_status";
DROP TYPE "order_status_old";
ALTER TABLE "order" ALTER COLUMN "order_status" SET DEFAULT 'CREATED';
COMMIT;
