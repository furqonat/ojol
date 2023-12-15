import { FirebaseService } from '@lugo/firebase'
import { Role } from '@lugo/guard'
import { PrismaService } from '@lugo/prisma'
import {
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common'

@Injectable()
export class MerchantService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebaseService: FirebaseService,
  ) {}

  async signIn(token: string) {
    const realToken = this.extractTokenFromBearer(token)
    if (!realToken) {
      throw new UnauthorizedException()
    }
    try {
      const merchant = await this.firebaseService.auth.verifyIdToken(realToken)

      const merchantIsExist = await this.getMerchant(merchant.uid)

      if (merchantIsExist) {
        await this.firebaseService.auth.setCustomUserClaims(merchant.uid, {
          roles: Role.MERCHANT,
        })
        return {
          message: 'OK',
          token: realToken,
        }
      } else {
        const userDb = await this.prismaService.merchant.create({
          data: {
            id: merchant.uid,
            email: merchant.email,
            phone: merchant.phone_number,
          },
        })

        await this.firebaseService.auth.setCustomUserClaims(userDb.id, {
          roles: Role.MERCHANT,
        })

        return {
          message: 'OK',
          token: realToken,
        }
      }
    } catch (e) {
      throw new InternalServerErrorException({ message: e })
    }
  }

  private async getMerchant(uid: string) {
    const merchant = await this.prismaService.merchant.findUnique({
      where: {
        id: uid,
      },
    })
    if (!merchant) {
      return undefined
    }
    return merchant
  }

  private extractTokenFromBearer(bearerToken: string): string | null {
    // Check if the string starts with "Bearer "
    if (bearerToken.startsWith('Bearer ')) {
      // Extract the token part after "Bearer "
      const token = bearerToken.substring(7)
      return token
    } else {
      return null // Invalid Bearer token format
    }
  }
}
