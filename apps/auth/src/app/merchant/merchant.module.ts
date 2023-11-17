import { Module } from '@nestjs/common'
import { MerchantService } from './merchant.service'

@Module({
  providers: [MerchantService],
})
export class MerchantModule {}
