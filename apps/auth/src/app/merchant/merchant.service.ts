import { FirebaseService } from '@lugo/firebase'
import { Role } from '@lugo/guard'
import { UsersPrismaService } from '@lugo/users'
import { Injectable } from '@nestjs/common'

@Injectable()
export class MerchantService {
  constructor(
    private readonly prismaService: UsersPrismaService,
    private readonly firebaseService: FirebaseService,
  ) {}

  async signIn(token: string) {
    const merchant = await this.firebaseService.auth.verifyIdToken(token)
    const { email, name, uid, phone_number } = merchant

    const merchantIsExist = this.getMerchant(uid)

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
    const merchant = await this.prismaService.merchant.findUniqueOrThrow({
      where: {
        id: uid,
      },
    })
    if (!merchant) {
      return undefined
    }
    return merchant
  }
}
