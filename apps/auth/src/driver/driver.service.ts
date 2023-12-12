import { FirebaseService } from '@lugo/firebase'
import { Injectable, UnauthorizedException } from '@nestjs/common'
import { Role } from '@lugo/guard'
import { PrismaService } from '@lugo/prisma'

@Injectable()
export class DriverService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebaseService: FirebaseService,
  ) {}

  async signIn(token: string) {
    const realToken = this.extractTokenFromBearer(token)
    if (!realToken) {
      throw new UnauthorizedException()
    }
    const driver = await this.firebaseService.auth.verifyIdToken(realToken)
    const { email, name, uid, phone_number } = driver

    const driverIsExist = await this.getDriver(uid)

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
    const driver = await this.prismaService.driver.findUnique({
      where: {
        id: uid,
      },
    })
    if (!driver) {
      return undefined
    }
    return driver
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
