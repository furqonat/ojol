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
  async getProducts(
    take: number,
    skip: number,
    select?: Prisma.productSelect,
    type?: 'FOOD' | 'MART',
    category?: string,
    query?: string,
    merchantId?: string,
  ) {
    const product = await this.prisma.product.findMany({
      where: {
        status: true,
        product_type: type ?? 'FOOD',
        category: category
          ? {
              some: {
                name: {
                  contains: category ?? undefined,
                },
              },
            }
          : undefined,
        merchant_id: merchantId ?? undefined,
        OR: query
          ? [
              {
                name: {
                  contains: query,
                },
              },
              {
                category: {
                  some: {
                    name: {
                      contains: query,
                    },
                  },
                },
              },
            ]
          : undefined,
      },
      select: select ? select : { id: true, name: true },
      take: take ? Number(take) : 10,
      skip: skip ? Number(skip) : 0,
    })

    const totalProduct = await this.prisma.product.count({
      where: {
        status: true,
        product_type: type ?? 'FOOD',
        category: {
          some: {
            name: {
              contains: category ?? undefined,
            },
          },
        },
        OR: query
          ? [
              {
                name: {
                  contains: query,
                },
              },
              {
                category: {
                  some: {
                    name: {
                      contains: query,
                    },
                  },
                },
              },
            ]
          : undefined,
      },
    })

    return {
      data: product,
      total: totalProduct,
    }
  }

  async getMerchants(
    take: number,
    skip: number,
    type: 'FOOD' | 'MART',
    select: Prisma.merchantSelect,
  ) {
    const merchants = await this.prisma.merchant.findMany({
      where: {
        type: type ?? 'FOOD',
      },
      select: select ?? {
        id: true,
        name: true,
        details: { select: { images: true } },
      },
      take: take ? Number(take) : 20,
      skip: skip ? Number(skip) : 0,
    })

    const totalMerchant = await this.prisma.merchant.count({
      where: {
        type: type ?? 'FOOD',
      },
    })

    return {
      data: merchants,
      total: totalMerchant,
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
      await this.prisma.favorites.delete({
        where: {
          product_id_customer_id: {
            customer_id: customerId,
            product_id: productId,
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
