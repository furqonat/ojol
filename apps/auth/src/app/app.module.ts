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
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      global: true,
    }),
    CustomerModule,
    MerchantModule,
    DriverModule,
    AdminModule,
    UsersModule,
    FirebaseModule,
    BcryptModule,
    GuardModule,
  ],
})
export class AppModule {}
