import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  Request,
  UseGuards,
} from '@nestjs/common'

import { AppService } from './app.service'
import { Role, Roles, RolesGuard } from '@lugo/guard'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '@lugo/common'

@UseGuards(RolesGuard)
@Controller()
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
    @Body('cartItemId') cartItemId: string,
    @Body('quantity') quantity: number,
  ) {
    return this.appService.updateProductFromCart(cartItemId, quantity)
  }

  @Roles(Role.USER)
  @Delete('/:id')
  async deleteProductFromCart(@Param('id') cartItemId: string) {
    return this.appService.deleteProductFromCart(cartItemId)
  }
}
