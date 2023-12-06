import { FirebaseService } from '@lugo/firebase'
import { UsersPrismaService } from '@lugo/users'
import { Module } from '@nestjs/common'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

@Module({
  providers: [CustomerService, UsersPrismaService, FirebaseService],
  controllers: [CustomerController],
})
export class CustomerModule {}
