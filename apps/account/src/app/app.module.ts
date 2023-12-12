import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { AdminModule } from '../admin/admin.module'
import { CustomerModule } from '../customer/customer.module'
import { DriverModule } from '../driver/driver.module'
import { MerchantModule } from '../merchant/merchant.module'

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    CustomerModule,
    DriverModule,
    MerchantModule,
    AdminModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
