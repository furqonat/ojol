import { Injectable, UnauthorizedException } from '@nestjs/common'
import { Role } from '@lugo/guard'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'

@Injectable()
export class CustomerService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebaseService: FirebaseService,
  ) {}

  async signIn(token: string) {
    const getToken = this.extractTokenFromBearer(token)
    if (!getToken) {
      throw new UnauthorizedException()
    }
    const user = await this.firebaseService.auth.verifyIdToken(getToken)
    const { email, name, uid, phone_number } = user

    const userIsExists = await this.getUser(uid)

    if (userIsExists) {
      const authToken = await this.firebaseService.auth.createCustomToken(uid, {
        roles: Role.USER,
      })
      return {
        message: 'OK',
        token: authToken,
      }
    } else {
      const userDb = await this.prismaService.customer.create({
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
          roles: Role.USER,
        },
      )

      return {
        message: 'OK',
        token: authToken,
      }
    }
  }

  private async getUser(uid: string) {
    const user = await this.prismaService.customer.findUnique({
      where: {
        id: uid,
      },
    })
    if (!user) {
      return undefined
    }
    return user
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
