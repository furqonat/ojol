import { FirebaseService } from '@lugo/firebase'
import { Prisma, UsersPrismaService } from '@lugo/users'
import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'

@Injectable()
export class MerchantService {
  constructor(
    private readonly prismaService: UsersPrismaService,
    private readonly firebase: FirebaseService,
  ) {}

  async getMerchant(token: string, select: Prisma.merchantSelect) {
    try {
      const decodeToken = await this.firebase.auth.verifyIdToken(token)
      const merchant = await this.prismaService.merchant.findUnique({
        where: {
          id: decodeToken.uid,
        },
        select: select ? select : { id: true },
      })
      return merchant
    } catch (e) {
      throw new NotFoundException()
    }
  }

  async applyMerchant(
    token: string,
    details: Prisma.merchant_detailsCreateInput,
  ) {
    try {
      const decodeToken = await this.firebase.auth.verifyIdToken(token)
      const alreadyApply = await this.prismaService.merchant_details.findUnique(
        {
          where: {
            merchant_id: decodeToken.uid,
          },
        },
      )
      if (alreadyApply) {
        throw new BadRequestException({ message: 'merchant already apply' })
      }
      const merchant = await this.prismaService.merchant.update({
        where: {
          id: decodeToken.uid,
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
}
