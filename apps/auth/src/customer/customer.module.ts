import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

@Module({
  providers: [CustomerService, PrismaService, FirebaseService],
  controllers: [CustomerController],
})
export class CustomerModule {}
