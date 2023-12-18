import { BadRequestException, Injectable } from '@nestjs/common'
import { Prisma, PrismaService } from '@lugo/prisma'

@Injectable()
export class AppService {
  constructor(private readonly prismaService: PrismaService) {}

  async getCarts(customerId: string, select: Prisma.cartSelect) {
    try {
      const carts = await this.prismaService.cart.findFirst({
        where: {
          customer_id: customerId,
        },
        select: select
          ? select
          : {
              id: true,
              cart_item: {
                include: {
                  product: true,
                },
              },
            },
      })
      const cartCount = await this.prismaService.cart_item.findMany({
        where: {
          cart: {
            customer_id: customerId,
          },
        },
        select: {
          quantity: true,
        },
      })
      return {
        data: carts,
        total: cartCount
          .map((item) => item.quantity)
          .reduce((a, b) => a + b, 0),
      }
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
        const item = await this.prismaService.cart_item.findFirst({
          where: {
            cart: {
              customer_id: customerId,
            },
            product_id: productId,
          },
        })
        if (item) {
          return await this.updateProductFromCart(
            customerId,
            productId,
            item.quantity + quantity,
          )
        }
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

  async updateProductFromCart(
    customerId: string,
    productId: string,
    quantity: number,
  ) {
    const cartItem = await this.prismaService.cart_item.findFirst({
      where: {
        cart: {
          customer_id: customerId,
        },
        product_id: productId,
      },
    })
    if (quantity < 1) {
      const cart = await this.prismaService.cart_item.delete({
        where: {
          id: cartItem.id,
        },
      })
      return {
        message: 'OK',
        res: cart.id,
      }
    } else {
      const cart = await this.prismaService.cart_item.update({
        where: {
          id: cartItem.id,
        },
        data: {
          quantity: quantity,
        },
      })
      return {
        message: 'OK',
        res: cart.id,
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
