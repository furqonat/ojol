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
    filter?: string,
    query?: string,
    merchantId?: string,
  ) {
    const product = await this.prisma.product.findMany({
      where: {
        status: true,
        product_type: type ?? 'FOOD',
        category: filter
          ? {
              some: {
                name: {
                  contains: filter ?? undefined,
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
              contains: filter ?? undefined,
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
        status: 'ACTIVE',
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

  async getCategories(take?: number, skip?: number) {
    const categories = await this.prisma.category.findMany({
      take: take ? Number(take) : 20,
      skip: skip ? Number(skip) : 0,
      select: {
        name: true,
        id: true,
      },
    })
    const total = await this.prisma.category.count()
    return {
      data: categories,
      total: total,
    }
  }

  async createCategory(name: string) {
    const categoryExist = await this.prisma.category.findMany({
      where: {
        name: {
          equals: this.capitalizeEachWord(name),
        },
      },
    })
    if (categoryExist.length > 0) {
      return {
        message: 'ALREADY EXIST',
        res: this.capitalizeEachWord(name),
      }
    }
    const category = await this.prisma.category.create({
      data: {
        name: this.capitalizeEachWord(name),
      },
    })
    return {
      res: category.id,
      message: 'OK',
    }
  }

  capitalizeEachWord(inputString: string): string {
    // Split the input string into an array of words
    const words: string[] = inputString.split(' ')

    // Capitalize the first letter of each word
    const capitalizedWords: string[] = words.map((word) =>
      this.capitalizeFirstLetter(word),
    )

    // Join the words back into a single string
    return capitalizedWords.join(' ')
  }

  capitalizeFirstLetter(inputString: string): string {
    // Check if the input string is not empty
    if (inputString.length === 0) {
      return inputString
    }

    // Capitalize the first letter and concatenate the rest of the string
    return inputString.charAt(0).toUpperCase() + inputString.slice(1)
  }
}
