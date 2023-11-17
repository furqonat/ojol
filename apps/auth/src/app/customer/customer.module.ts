import { FirebaseService } from '@lugo/firebase'
import { Module } from '@nestjs/common'
import { PrismaService } from '../prisma'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

@Module({
  providers: [CustomerService, PrismaService, FirebaseService],
  controllers: [CustomerController],
})
export class CustomerModule {}
