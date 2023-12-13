import { BadRequestException, Injectable } from '@nestjs/common'
import { Prisma, PrismaService } from '@lugo/prisma'

@Injectable()
export class AppService {
  constructor(private readonly prismaService: PrismaService) {}

  async getCarts(customerId: string, select: Prisma.cartSelect) {
    try {
      const carts = this.prismaService.cart.findMany({
        where: {
          customer_id: customerId,
        },
        select: select ? select : { id: true, cart_item: true },
      })
      return carts
    } catch (e) {
      throw new BadRequestException(e)
    }
  }

  async addProductToCart(
    customerId: string,
    productId: string,
    quantity: number,
  ) {
    try {
      const cartExists = await this.prismaService.cart.findUnique({
        where: {
          customer_id: customerId,
        },
      })
      if (quantity < 1) {
        throw new BadRequestException({
          message: 'quantity must be greather than 0',
        })
      }
      if (cartExists) {
        await this.prismaService.cart.update({
          where: {
            id: cartExists.id,
          },
          data: {
            cart_item: {
              create: {
                product_id: productId,
                quantity: quantity,
              },
            },
          },
        })
        return {
          message: 'OK',
          res: productId,
        }
      } else {
        await this.prismaService.cart.create({
          data: {
            customer_id: customerId,
            cart_item: {
              create: {
                product_id: productId,
                quantity: quantity,
              },
            },
          },
        })
        return {
          message: 'OK',
          res: productId,
        }
      }
    } catch (e) {
      throw new BadRequestException(e)
    }
  }

  async updateProductFromCart(cartItemId: string, quantity: number) {
    if (quantity < 1) {
      const cartItem = await this.prismaService.cart_item.delete({
        where: {
          id: cartItemId,
        },
      })
      return {
        message: 'OK',
        res: cartItem.id,
      }
    } else {
      const cartItem = await this.prismaService.cart_item.update({
        where: {
          id: cartItemId,
        },
        data: {
          quantity: quantity,
        },
      })
      return {
        message: 'OK',
        res: cartItem.id,
      }
    }
  }

  async deleteProductFromCart(cartItemId: string) {
    const cartItem = await this.prismaService.cart_item.delete({
      where: {
        id: cartItemId,
      },
    })
    return {
      message: 'OK',
      res: cartItem.cart_id,
    }
  }
}
