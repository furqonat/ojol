import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '../prisma/prisma.service'
import { Injectable } from '@nestjs/common'
import { Role } from '@lugo/guard'

@Injectable()
export class DriverService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebaseService: FirebaseService,
  ) {}

  async signIn(token: string) {
    const driver = await this.firebaseService.auth.verifyIdToken(token)
    const { email, name, uid, phone_number } = driver

    const driverIsExist = this.getDriver(uid)

    if (driverIsExist) {
      const authToken = await this.firebaseService.auth.createCustomToken(uid, {
        roles: Role.DRIVER,
      })
      return {
        message: 'OK',
        token: authToken,
      }
    } else {
      const userDb = await this.prismaService.driver.create({
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
          roles: Role.DRIVER,
        },
      )

      return {
        message: 'OK',
        token: authToken,
      }
    }
  }

  private async getDriver(uid: string) {
    const driver = await this.prismaService.driver.findUniqueOrThrow({
      where: {
        id: uid,
      },
    })
    if (!driver) {
      return undefined
    }
    return driver
  }
}
