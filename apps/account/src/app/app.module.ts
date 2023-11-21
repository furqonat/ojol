import { Module } from '@nestjs/common'
import { CustomerModule } from './customer/customer.module'
import { AdminModule } from './admin/admin.module'
import { GuardModule } from '@lugo/guard'
import { FirebaseModule } from '@lugo/firebase'
import { ConfigModule } from '@nestjs/config'
import { JwtModule } from '@nestjs/jwt'

@Module({
  imports: [
    CustomerModule,
    AdminModule,
    GuardModule,
    FirebaseModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      global: true,
    }),
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
