import {
  Body,
  Controller,
  Delete,
  Get,
  Headers,
  Param,
  Post,
  Put,
  Query,
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
    @Headers('Authorization') token: string,
    @Query() select: Prisma.cartSelect,
  ) {
    return this.appService.getCarts(token, str2obj(select))
  }

  @Roles(Role.USER)
  @Post()
  async addProductToCart(
    @Headers('Authorization') token: string,
    @Body('productId') productId: string,
    @Body('quantity') quantity: number,
  ) {
    return this.appService.addProductToCart(token, productId, quantity)
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
