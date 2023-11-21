import { Module } from '@nestjs/common'

import { BcryptModule } from '@lugo/bcrypt'
import { FirebaseModule } from '@lugo/firebase'
import { ConfigModule } from '@nestjs/config'
import { AdminModule } from './admin/admin.module'
import { CustomerModule } from './customer/customer.module'
import { DriverModule } from './driver/driver.module'
import { MerchantModule } from './merchant/merchant.module'
import { GuardModule } from '@lugo/guard'
import { UsersModule } from '@lugo/users'
import { JwtModule } from '@nestjs/jwt'

@Module({
  imports: [
    CustomerModule,
    MerchantModule,
    DriverModule,
    AdminModule,
    UsersModule,
    FirebaseModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    BcryptModule,
    GuardModule,
    JwtModule.register({
      global: true,
      secret: process.env.JWT_SECRET,
    }),
  ],
})
export class AppModule {}
