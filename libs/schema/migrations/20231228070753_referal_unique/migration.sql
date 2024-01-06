/*
  Warnings:

  - A unique constraint covering the columns `[ref]` on the table `referal` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "referal_ref_key" ON "referal"("ref");
