import { FirebaseModule } from '@lugo/firebase'
import { GuardModule } from '@lugo/guard'
import { JwtGuardModule } from '@lugo/jwtguard'
import { UsersModule } from '@lugo/users'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { AdminModule } from '../admin/admin.module'
import { CustomerModule } from '../customer/customer.module'

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    CustomerModule,
    AdminModule,
    GuardModule,
    FirebaseModule,
    UsersModule,
    JwtGuardModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
