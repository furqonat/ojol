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
    details: Prisma.merchant_detailsUpdateOneWithoutMerchantNestedInput,
  ) {
    try {
      const alreadyApply = await this.prismaService.merchant_details.findUnique(
        {
          where: {
            merchant_id: merchantId,
          },
        },
      )
      if (alreadyApply && details?.create) {
        throw new BadRequestException({ message: 'merchant already apply' })
      }
      if (alreadyApply && details?.delete) {
        throw new BadRequestException({ message: 'cannot deleted' })
      }
      const merchant = await this.prismaService.merchant.update({
        where: {
          id: merchantId,
        },
        data: {
          details: {
            update: {
              images: {
                update: {
                  where: {
                    id: '',
                  },
                  data: {
                    link: '',
                  },
                },
              },
            },
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

  async createOrUpdateOperationTime(
    merchantId: string,
    data: Prisma.merchant_operation_timeUpdateManyWithoutMerchant_detailsNestedInput,
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
            operation_time: data,
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

  async saveDeviceToken(merchantId: string, token: string) {
    const deviceTokenExist =
      await this.prismaService.merchant_device_token.findUnique({
        where: {
          merchant_id: merchantId,
        },
      })
    if (deviceTokenExist) {
      const deviceToken = await this.prismaService.merchant_device_token.update(
        {
          where: {
            merchant_id: merchantId,
          },
          data: {
            token: token,
          },
        },
      )
      return {
        message: 'OK',
        res: deviceToken.id,
      }
    }
    const deviceToken = await this.prismaService.merchant_device_token.create({
      data: {
        token: token,
        merchant_id: merchantId,
      },
    })
    return {
      message: 'OK',
      res: deviceToken.id,
    }
  }
}
