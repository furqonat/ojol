import { Module } from '@nestjs/common'

import { BcryptModule } from '@lugo/bcrypt'
import { FirebaseModule } from '@lugo/firebase'
import { ConfigModule } from '@nestjs/config'
import { AdminModule } from './admin/admin.module'
import { CustomerModule } from './customer/customer.module'
import { DriverModule } from './driver/driver.module'
import { MerchantModule } from './merchant/merchant.module'
import { PrismaModule } from './prisma/prisma.module'
import { GuardModule } from '@lugo/guard'

@Module({
  imports: [
    CustomerModule,
    MerchantModule,
    DriverModule,
    AdminModule,
    PrismaModule,
    FirebaseModule,
    ConfigModule.forRoot(),
    BcryptModule,
    GuardModule,
  ],
})
export class AppModule {}
