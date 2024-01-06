import {
  Body,
  Controller,
  Get,
  Post,
  Put,
  Query,
  Request,
  UnauthorizedException,
  UseGuards,
} from '@nestjs/common'

import { str2obj } from '@lugo/common'
import { Role, Roles, RolesGuard } from '@lugo/guard'
import { Prisma } from '@prisma/client/users'
import { AppService } from './app.service'

@UseGuards(RolesGuard)
@Controller('cart')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Roles(Role.USER)
  @Get()
  async getCarts(
    @Query() select: Prisma.cartSelect,
    @Request() req?: { uid?: string },
  ) {
    return this.appService.getCarts(req?.uid, str2obj(select))
  }

  @Roles(Role.USER)
  @Post()
  async addProductToCart(
    @Body('productId') productId: string,
    @Body('quantity') quantity: number,
    @Request() req?: { uid?: string },
  ) {
    return this.appService.addProductToCart(req?.uid, productId, quantity)
  }

  @Roles(Role.USER)
  @Put()
  async updateProductFromCart(
    @Body('productId') productId: string,
    @Body('quantity') quantity: number,
    @Request() req?: { uid?: string },
  ) {
    if (req?.uid) {
      return this.appService.updateProductFromCart(
        req?.uid,
        productId,
        quantity,
      )
    } else {
      throw new UnauthorizedException()
    }
  }
}
