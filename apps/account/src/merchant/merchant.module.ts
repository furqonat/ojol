import { Module } from '@nestjs/common'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { PrismaService } from '@lugo/prisma'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

@Module({
  controllers: [MerchantController],
  providers: [
    MerchantService,
    PrismaService,
    FirebaseService,
    ConfigService,
  ],
})
export class MerchantModule {}
