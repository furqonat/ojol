import { Module } from '@nestjs/common'
import { MerchantService } from './merchant.service'
import { MerchantController } from './merchant.controller'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'

@Module({
  providers: [MerchantService, PrismaService, FirebaseService],
  controllers: [MerchantController],
})
export class MerchantModule {}
