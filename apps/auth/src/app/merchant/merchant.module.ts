import { Module } from '@nestjs/common'
import { MerchantService } from './merchant.service'
import { MerchantController } from './merchant.controller'
import { FirebaseService } from '@lugo/firebase'
import { UsersPrismaService } from '@lugo/users'

@Module({
  providers: [MerchantService, UsersPrismaService, FirebaseService],
  controllers: [MerchantController],
})
export class MerchantModule {}
