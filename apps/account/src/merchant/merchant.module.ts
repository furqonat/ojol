import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { FirebaseModule } from '@lugo/firebase'

@Module({
  imports: [PrismaModule, FirebaseModule, GuardModule],
  controllers: [MerchantController],
  providers: [MerchantService],
})
export class MerchantModule {}
