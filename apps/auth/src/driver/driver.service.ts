import { FirebaseService } from '@lugo/firebase'
import {
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common'
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
    try {
      const driver = await this.firebaseService.auth.verifyIdToken(realToken)

      const driverIsExist = await this.getDriver(driver.uid)

      if (driverIsExist) {
        const authToken = await this.firebaseService.auth.createCustomToken(
          driver.uid,
          {
            roles: Role.DRIVER,
          },
        )
        return {
          message: 'OK',
          token: authToken,
        }
      } else {
        const userDb = await this.prismaService.driver.create({
          data: {
            id: driver.uid,
            email: driver.email,
            phone: driver.phone_number,
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
    } catch (e) {
      throw new InternalServerErrorException({ message: e })
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
