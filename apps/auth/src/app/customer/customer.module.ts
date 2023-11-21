import { FirebaseService } from '@lugo/firebase'
import { Module } from '@nestjs/common'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'
import { UsersModule } from '@lugo/users'

@Module({
  providers: [CustomerService, UsersModule, FirebaseService],
  controllers: [CustomerController],
})
export class CustomerModule {}
