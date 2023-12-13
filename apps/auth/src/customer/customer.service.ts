import {
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common'
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
    try {
      const user = await this.firebaseService.auth.verifyIdToken(getToken)

      const userIsExists = await this.getUser(user.uid)

      if (userIsExists) {
        const authToken = await this.firebaseService.auth.createCustomToken(
          user.uid,
          {
            roles: Role.USER,
          },
        )
        return {
          message: 'OK',
          token: authToken,
        }
      } else {
        const userDb = await this.prismaService.customer.create({
          data: {
            id: user.uid,
            email: user.email,
            phone: user.phone_number,
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
    } catch (e) {
      throw new InternalServerErrorException({ message: e })
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
