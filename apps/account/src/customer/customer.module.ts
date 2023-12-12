import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'
import { GuardModule } from '@lugo/guard'

@Module({
  imports: [ConfigModule, FirebaseModule, PrismaModule, GuardModule],
  providers: [CustomerService],
  controllers: [CustomerController],
})
export class CustomerModule {}
