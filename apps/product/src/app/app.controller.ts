import { Role, Roles, RolesGuard } from '@lugo/guard'
import {
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
@Controller('product')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Roles(Role.MERCHANT, Role.USER)
  @Get()
  async getProducts(
    @Query('take') take: number,
    @Query('skip') skip: number,
    @Query() select: Prisma.productSelect,
  ) {
    return this.appService.getProducts(take, skip, str2obj(select))
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
  @Get('/:id')
  async getProduct(
    @Param('id') productId: string,
    @Query() select?: Prisma.productSelect,
  ) {
    return this.appService.getProduct(productId, str2obj(select))
  }
}
