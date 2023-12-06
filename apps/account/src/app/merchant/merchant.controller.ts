import {
  Body,
  Controller,
  Get,
  Headers,
  Post,
  Put,
  Query,
} from '@nestjs/common'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '../utility'
import { MerchantService } from './merchant.service'

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

  @Post('/operation')
  async createOperationTime(
    @Headers('Authorization') token?: string,
    @Body() data?: Prisma.merchant_operation_timeCreateInput,
  ) {
    return this.merchantService.createOperationTime(token, data)
  }

  @Put('/operation')
  async updateOperationTime(
    @Headers('Authorization') token?: string,
    @Body() data?: Prisma.merchant_operation_timeUpdateInput,
  ) {
    return this.merchantService.updateOperationTime(token, data)
  }
}
