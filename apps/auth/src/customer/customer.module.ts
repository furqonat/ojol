import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

@Module({
  imports: [PrismaModule, FirebaseModule],
  providers: [CustomerService],
  controllers: [CustomerController],
})
export class CustomerModule {}
