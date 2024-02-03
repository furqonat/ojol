import {
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common'
import { Role } from '@lugo/guard'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'
import { DecodedIdToken } from 'firebase-admin/auth'
import { nameGenerator } from '@lugo/common'

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

    const user = await this.verifyFirebaseToken(getToken)
    const userIsExists = await this.getUser(user.uid)

    if (userIsExists) {
      return this.handleExistingUser(user.uid, getToken)
    }

    return this.handleNewUser(user, getToken)
  }

  private async verifyFirebaseToken(token: string) {
    try {
      return await this.firebaseService.auth.verifyIdToken(token)
    } catch (e) {
      throw new InternalServerErrorException({ message: e })
    }
  }

  private async handleExistingUser(uid: string, token: string) {
    await this.firebaseService.auth.setCustomUserClaims(uid, {
      roles: Role.USER,
    })
    return { message: 'OK', token: token }
  }

  private async handleNewUser(user: DecodedIdToken, token: string) {
    const userDb = await this.prismaService.customer.create({
      data: {
        id: user.uid,
        email: user.email,
        phone: user.phone_number,
        name: user.name ?? nameGenerator(),
      },
    })

    await this.firebaseService.auth.setCustomUserClaims(userDb.id, {
      roles: Role.USER,
    })

    return { message: 'OK', token: token }
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
