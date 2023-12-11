import { FirebaseModule } from '@lugo/firebase'
import { UsersModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

@Module({
  imports: [UsersModule, FirebaseModule],
  providers: [CustomerService],
  controllers: [CustomerController],
})
export class CustomerModule {}
