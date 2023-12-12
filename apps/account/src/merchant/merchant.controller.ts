import {
  Body,
  Controller,
  Get,
  Headers,
  Post,
  Put,
  Query,
  UseGuards,
} from '@nestjs/common'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '@lugo/common'
import { MerchantService } from './merchant.service'
import { Role, Roles, RolesGuard } from '@lugo/guard'

@UseGuards(RolesGuard)
@Controller('merchant')
export class MerchantController {
  constructor(private readonly merchantService: MerchantService) {}

  @Roles(Role.MERCHANT)
  @Get()
  async getMerchant(
    @Headers('Authorization') token?: string,
    @Query() select?: Prisma.merchantSelect,
  ) {
    return this.merchantService.getMerchant(token, str2obj(select))
  }

  @Roles(Role.MERCHANT)
  @Post()
  async applyToBeMerchant(
    @Headers('Authorization') token?: string,
    @Body() details?: Prisma.merchant_detailsCreateInput,
  ) {
    return this.merchantService.applyMerchant(token, details)
  }

  @Roles(Role.MERCHANT)
  @Post('/operation')
  async createOperationTime(
    @Headers('Authorization') token?: string,
    @Body() data?: Prisma.merchant_operation_timeCreateInput,
  ) {
    return this.merchantService.createOperationTime(token, data)
  }

  @Roles(Role.MERCHANT)
  @Put('/operation')
  async updateOperationTime(
    @Headers('Authorization') token?: string,
    @Body() data?: Prisma.merchant_operation_timeUpdateInput,
  ) {
    return this.merchantService.updateOperationTime(token, data)
  }
}
