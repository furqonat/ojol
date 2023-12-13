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
  async getProducts(take: number, skip: number, select: Prisma.productSelect) {
    return this.prisma.product.findMany({
      select: select ? select : { id: true, name: true },
      take: take ? Number(take) : 10,
      skip: skip ? Number(skip) : 0,
    })
  }

  async createProduct(
    merchantId: string,
    data: Omit<Prisma.productCreateInput, 'merchant'>,
  ) {
    return this.prisma.product.create({
      data: {
        ...data,
        merchant: {
          connect: {
            id: merchantId,
          },
        },
      },
    })
  }

  async updateProduct(productId: string, data: Prisma.productUpdateInput) {
    return this.prisma.product.update({
      where: {
        id: productId,
      },
      data: data,
    })
  }
}
