import { FirebaseModule } from '@lugo/firebase'
import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'

@Module({
  imports: [PrismaModule, GuardModule, FirebaseModule],
  controllers: [MerchantController],
  providers: [MerchantService],
})
export class MerchantModule {}
