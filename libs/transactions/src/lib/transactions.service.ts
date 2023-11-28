import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common'
import { PrismaClient } from '@prisma/client/transactions'

@Injectable()
export class TransactionsPrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  async onModuleInit() {
    this.$connect()
  }

  async onModuleDestroy() {
    this.$disconnect()
  }
}
