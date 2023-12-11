import { Module } from '@nestjs/common'
import { CustomerService } from './customer.service'
import { CustomerController } from './customer.controller'
import { PrismaService } from '@lugo/prisma'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

@Module({
  providers: [
    CustomerService,
    PrismaService,
    FirebaseService,
    ConfigService,
  ],
  controllers: [CustomerController],
})
export class CustomerModule {}
