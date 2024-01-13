import { Role, Roles, RolesGuard } from '@lugo/guard'
import {
  BadRequestException,
  Body,
  Controller,
  Get,
  Param,
  Post,
  Put,
  Query,
  Request,
  UnauthorizedException,
  UseGuards,
} from '@nestjs/common'

import { AppService } from './app.service'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '@lugo/common'

@UseGuards(RolesGuard)
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Roles(Role.MERCHANT, Role.USER)
  @Get()
  async getProducts(
    @Query('take') take: number,
    @Query('skip') skip: number,
    @Query('query') query: string,
    @Query('type') type: 'FOOD' | 'MART' = 'FOOD',
    @Query('filter') filter: string,
    @Query('merchant_id') merchantId: string,
    @Query() select: Prisma.productSelect,
  ) {
    return this.appService.getProducts(
      take,
      skip,
      str2obj(select),
      type,
      filter,
      query,
      merchantId,
    )
  }

  @Roles(Role.MERCHANT)
  @Post()
  async createProduct(
    @Body() data: Omit<Prisma.productCreateInput, 'merchant'>,
    @Request() req?: { uid?: string },
  ) {
    if (req?.uid) {
      return this.appService.createProduct(req?.uid, data)
    } else {
      throw new UnauthorizedException({ message: 'Please provide the token' })
    }
  }

  @Roles(Role.USER)
  @Get('/merchants')
  async getMerchants(
    @Query('take') take: number,
    @Query('skip') skip: number,
    @Query('type') type: 'FOOD' | 'MART',
    @Query() select: Prisma.merchantSelect,
  ) {
    return this.appService.getMerchants(take, skip, type, str2obj(select))
  }

  @Roles(Role.MERCHANT)
  @Put('/:id')
  async updateProduct(
    @Param('id') productId: string,
    @Body() data: Prisma.productUpdateInput,
  ) {
    return this.appService.updateProduct(productId, data)
  }
  @Roles(Role.USER)
  @Get('/favorite/:id')
  async addOrDeleteProductFromFavorite(
    @Param('id') productId: string,
    @Request() req?: { uid?: string },
  ) {
    if (req?.uid) {
      return this.appService.addOrDeleteProductToFavotites(req.uid, productId)
    } else {
      throw new UnauthorizedException()
    }
  }
  @Roles(Role.MERCHANT, Role.USER)
  @Get('/category')
  async getCategories(
    @Query('merchantId') merchantId?: string,
    @Query('take') take = 20,
    @Query('skip') skip = 0,
  ) {
    return this.appService.getCategories({
      merchantId: merchantId,
      take: take,
      skip: skip,
    })
  }

  @Roles(Role.MERCHANT, Role.USER)
  @Get('/merchant/category')
  async getMerchantCategories(
    @Request() req?: { uid?: string },
    @Query('take') take = 20,
    @Query('skip') skip = 0,
  ) {
    if (req?.uid) {
      return this.appService.getCategories({
        merchantId: req.uid,
        take: take,
        skip: skip,
      })
    }
    throw new UnauthorizedException({ message: 'Unauthorized' })
  }

  @Roles(Role.MERCHANT, Role.USER)
  @Post('/category')
  async createCategories(@Body('name') name: string) {
    if (!name) {
      throw new BadRequestException()
    }
    return this.appService.createCategory(name)
  }
  @Roles(Role.MERCHANT, Role.USER)
  @Get('/:id')
  async getProduct(
    @Param('id') productId: string,
    @Query() select?: Prisma.productSelect,
  ) {
    return this.appService.getProduct(productId, str2obj(select))
  }
}
