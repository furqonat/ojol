import { Injectable } from '@nestjs/common'
import { PrismaService } from '../prisma'
import { Role } from '@lugo/guard'
import { FirebaseService } from '@lugo/firebase'

@Injectable()
export class CustomerService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebaseService: FirebaseService,
  ) {}

  async signIn(token: string) {
    const user = await this.firebaseService.auth.verifyIdToken(token)
    const { email, name, uid, phone_number } = user

    const userIsExists = this.getUser(uid)

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
    const user = await this.prismaService.customer.findUniqueOrThrow({
      where: {
        id: uid,
      },
    })
    if (!user) {
      return undefined
    }
    return user
  }
}
