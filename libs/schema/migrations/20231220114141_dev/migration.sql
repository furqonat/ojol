-- CreateTable
CREATE TABLE "dana_token" (
    "id" TEXT NOT NULL,
    "customer_id" TEXT NOT NULL,
    "access_token" TEXT NOT NULL,
    "expires_in" TIMESTAMP(3) NOT NULL,
    "refresh_token" TIMESTAMP(3) NOT NULL,
    "re_expires_in" TIMESTAMP(3) NOT NULL,
    "token_status" TEXT NOT NULL,
    "dana_user_id" TEXT NOT NULL,

    CONSTRAINT "dana_token_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "dana_token" ADD CONSTRAINT "dana_token_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;
