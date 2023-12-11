import { Injectable } from '@nestjs/common'
import { FirebaseService } from '@lugo/firebase'
import { Prisma, PrismaService } from '@lugo/prisma'

@Injectable()
export class AppService {
  constructor(
    private readonly firebase: FirebaseService,
    private readonly prisma: PrismaService,
  ) {}

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
}
