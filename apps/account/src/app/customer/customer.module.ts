import { Module } from '@nestjs/common'
import { CustomerService } from './customer.service'
import { CustomerController } from './customer.controller'
import { UsersPrismaService } from '@lugo/users'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

@Module({
  providers: [
    CustomerService,
    UsersPrismaService,
    FirebaseService,
    ConfigService,
  ],
  controllers: [CustomerController],
})
export class CustomerModule {}
