import { Prisma, PrismaService } from '@lugo/prisma'
import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'

@Injectable()
export class MerchantService {
  constructor(private readonly prismaService: PrismaService) {}

  async getMerchant(merchantId: string, select: Prisma.merchantSelect) {
    try {
      const merchant = await this.prismaService.merchant.findUnique({
        where: {
          id: merchantId,
        },
        select: select ? select : { id: true },
      })
      return merchant
    } catch (e) {
      throw new NotFoundException()
    }
  }

  async applyMerchant(
    merchantId: string,
    details: Prisma.merchant_detailsCreateInput,
  ) {
    try {
      const alreadyApply = await this.prismaService.merchant_details.findUnique(
        {
          where: {
            merchant_id: merchantId,
          },
        },
      )
      if (alreadyApply) {
        throw new BadRequestException({ message: 'merchant already apply' })
      }
      const merchant = await this.prismaService.merchant.update({
        where: {
          id: merchantId,
        },
        data: {
          details: {
            create: details,
          },
        },
        select: {
          details: {
            select: {
              id: true,
            },
          },
        },
      })
      return {
        message: 'OK',
        res: merchant.details.id,
      }
    } catch (e) {
      throw new BadRequestException({ message: 'Internal Error' })
    }
  }

  async createOperationTime(
    merchantId: string,
    data: Omit<
      Prisma.merchant_operation_timeCreateInput,
      'id' | 'merchant_details'
    >,
  ) {
    try {
      const merchant = await this.prismaService.merchant.findUnique({
        where: {
          id: merchantId,
        },
        select: {
          details: {
            select: {
              id: true,
            },
          },
        },
      })
      if (merchant.details.id) {
        const details = await this.prismaService.merchant_details.update({
          where: {
            id: merchant.details.id,
          },
          data: {
            operation_time: {
              create: data,
            },
          },
        })
        return {
          message: 'OK',
          res: details.id,
        }
      } else {
        throw new BadRequestException()
      }
    } catch (e) {
      throw new BadRequestException(e)
    }
  }

  async updateOperationTime(
    opId: string,
    data: Prisma.merchant_operation_timeUpdateInput,
  ) {
    const res = this.prismaService.merchant_operation_time.update({
      where: {
        id: opId,
      },
      data: data,
    })
    return {
      message: 'OK',
      res: res,
    }
  }
}
