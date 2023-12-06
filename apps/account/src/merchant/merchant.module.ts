import { Module } from '@nestjs/common'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { UsersPrismaService } from '@lugo/users'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

@Module({
  controllers: [MerchantController],
  providers: [
    MerchantService,
    UsersPrismaService,
    FirebaseService,
    ConfigService,
  ],
})
export class MerchantModule {}
