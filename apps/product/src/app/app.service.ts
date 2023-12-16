import { Prisma, PrismaService } from '@lugo/prisma'
import { Injectable } from '@nestjs/common'

@Injectable()
export class AppService {
  constructor(private readonly prisma: PrismaService) {}

  async getProduct(productId: string, select: Prisma.productSelect) {
    return this.prisma.product.findUnique({
      where: {
        id: productId,
      },
      select: select ? select : { id: true, name: true },
    })
  }
  async getProducts(take: number, skip: number, select?: Prisma.productSelect) {
    const product = await this.prisma.product.findMany({
      where: {
        status: true,
      },
      select: select ? select : { id: true, name: true },
      take: take ? Number(take) : 10,
      skip: skip ? Number(skip) : 0,
    })

    const totalProduct = await this.prisma.product.count()

    return {
      data: product,
      total: totalProduct,
    }
  }

  async createProduct(
    merchantId: string,
    data: Omit<Prisma.productCreateInput, 'merchant'>,
  ) {
    const merchant = await this.prisma.merchant.findUnique({
      where: {
        id: merchantId,
      },
    })
    const product = await this.prisma.product.create({
      data: {
        ...data,
        merchant: {
          connect: {
            id: merchantId,
          },
        },
        product_type: merchant.type,
      },
    })
    return {
      message: 'OK',
      res: product.id,
    }
  }

  async updateProduct(productId: string, data: Prisma.productUpdateInput) {
    const product = await this.prisma.product.update({
      where: {
        id: productId,
      },
      data: data,
    })
    return {
      message: 'OK',
      res: product.id,
    }
  }

  async addOrDeleteProductToFavotites(customerId: string, productId: string) {
    const isExists = await this.prisma.favorites.findUnique({
      where: {
        product_id_customer_id: {
          product_id: productId,
          customer_id: customerId,
        },
      },
    })
    if (isExists) {
      await this.prisma.product.update({
        where: {
          id: productId,
        },
        data: {
          favorites: {
            disconnect: {
              product_id_customer_id: {
                customer_id: customerId,
                product_id: productId,
              },
            },
          },
        },
      })
      return {
        message: 'OK',
        res: productId,
      }
    } else {
      await this.prisma.favorites.create({
        data: {
          customer_id: customerId,
          product_id: productId,
        },
      })
      return {
        message: 'OK',
        res: productId,
      }
    }
  }
}
