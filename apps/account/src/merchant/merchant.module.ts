import { FirebaseModule } from '@lugo/firebase'
import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'

@Module({
  imports: [ConfigModule, FirebaseModule, PrismaModule, GuardModule],
  controllers: [MerchantController],
  providers: [MerchantService],
})
export class MerchantModule {}
