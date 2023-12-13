import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'

@Module({
  imports: [PrismaModule, GuardModule],
  controllers: [MerchantController],
  providers: [MerchantService],
})
export class MerchantModule {}
