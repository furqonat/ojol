import { Body, Controller, Get, Headers, Post, Query } from '@nestjs/common'
import { MerchantService } from './merchant.service'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '../utility'

@Controller('merchant')
export class MerchantController {
  constructor(private readonly merchantService: MerchantService) {}

  @Get()
  async getMerchant(
    @Headers('Authorization') token?: string,
    @Query() select?: Prisma.merchantSelect,
  ) {
    return this.merchantService.getMerchant(token, str2obj(select))
  }

  @Post()
  async applyToBeMerchant(
    @Headers('Authorization') token?: string,
    @Body() details?: Prisma.merchant_detailsCreateInput,
  ) {
    return this.merchantService.applyMerchant(token, details)
  }
}
