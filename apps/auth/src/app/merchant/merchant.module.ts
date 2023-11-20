import { Module } from '@nestjs/common'
import { MerchantService } from './merchant.service'
import { MerchantController } from './merchant.controller'
import { PrismaService } from '../prisma/prisma.service'
import { FirebaseService } from '@lugo/firebase'

@Module({
  providers: [MerchantService, PrismaService, FirebaseService],
  controllers: [MerchantController],
})
export class MerchantModule {}
