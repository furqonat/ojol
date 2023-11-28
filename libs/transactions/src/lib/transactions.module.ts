import { Module } from '@nestjs/common'
import { TransactionsPrismaService } from './transactions.service'

@Module({
  controllers: [],
  providers: [TransactionsPrismaService],
  exports: [TransactionsPrismaService],
})
export class TransactionsModule {}
