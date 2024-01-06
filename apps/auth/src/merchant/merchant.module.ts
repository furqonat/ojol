import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'

@Module({
  imports: [ConfigModule, PrismaModule, FirebaseModule],
  providers: [MerchantService],
  controllers: [MerchantController],
})
export class MerchantModule {}
