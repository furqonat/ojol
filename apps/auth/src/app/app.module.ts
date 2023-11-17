import { Module } from '@nestjs/common'

import { AppController } from './app.controller'
import { AppService } from './app.service'
import { CustomerModule } from './customer/customer.module'
import { MerchantModule } from './merchant/merchant.module'
import { DriverModule } from './driver/driver.module'
import { AdminModule } from './admin/admin.module'
import { PrismaModule } from './prisma/prisma.module'
import { FirebaseModule, FirebaseService } from '@lugo/firebase'
import { PrismaService } from './prisma'

@Module({
  imports: [
    CustomerModule,
    MerchantModule,
    DriverModule,
    AdminModule,
    PrismaModule,
    FirebaseModule,
  ],
  controllers: [AppController],
  providers: [AppService, FirebaseService, PrismaService],
})
export class AppModule {}
