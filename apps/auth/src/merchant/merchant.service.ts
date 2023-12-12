import { FirebaseService } from '@lugo/firebase'
import { Role } from '@lugo/guard'
import { PrismaService } from '@lugo/prisma'
import { Injectable, UnauthorizedException } from '@nestjs/common'

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
    const merchant = await this.firebaseService.auth.verifyIdToken(realToken)
    const { email, name, uid, phone_number } = merchant

    const merchantIsExist = await this.getMerchant(uid)

    if (merchantIsExist) {
      const authToken = await this.firebaseService.auth.createCustomToken(uid, {
        roles: Role.MERCHANT,
      })
      return {
        message: 'OK',
        token: authToken,
      }
    } else {
      const userDb = await this.prismaService.merchant.create({
        data: {
          id: uid,
          email: email,
          phone: phone_number,
          name: name,
        },
      })

      const authToken = await this.firebaseService.auth.createCustomToken(
        userDb.id,
        {
          roles: Role.MERCHANT,
        },
      )

      return {
        message: 'OK',
        token: authToken,
      }
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
