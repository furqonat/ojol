import { FirebaseService } from '@lugo/firebase'
import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

@Module({
  imports: [ConfigModule, PrismaModule, GuardModule],
  providers: [CustomerService, FirebaseService],
  controllers: [CustomerController],
})
export class CustomerModule {}
