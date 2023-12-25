import { Prisma, PrismaService } from '@lugo/prisma'
import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common'

@Injectable()
export class DriverService {
  constructor(private readonly prismaService: PrismaService) {}

  async getDriver(driverId: string, select?: Prisma.driverSelect) {
    try {
      const driver = await this.prismaService.driver.findUnique({
        where: {
          id: driverId,
        },
        select: select ? select : { id: true },
      })
      return driver
    } catch (e) {
      throw new NotFoundException({ message: 'Driver not found', error: e })
    }
  }

  async applyDriver(
    driverId: string,
    options: {
      details: Prisma.driver_detailsCreateInput
    },
  ) {
    const { details } = options
    try {
      const alreadyApply = await this.prismaService.driver_details.findUnique({
        where: {
          driver_id: driverId,
        },
      })
      if (alreadyApply) {
        throw new BadRequestException({ message: 'already apply for driver' })
      }
      const createDetail = await this.prismaService.driver.update({
        where: {
          id: driverId,
        },
        data: {
          driver_details: {
            create: details,
          },
        },
        include: {
          driver_details: true,
        },
      })
      return {
        message: 'OK',
        res: createDetail.driver_details.id,
      }
    } catch (e) {
      throw new BadRequestException({
        message: 'Unexpected error',
        error: e,
      })
    }
  }

  async updateDriverDetail(
    driverId: string,
    options: Prisma.driver_detailsUpdateInput,
  ) {
    try {
      const driver = await this.prismaService.driver_details.update({
        where: {
          driver_id: driverId,
        },
        data: options,
      })
      return {
        message: 'OK',
        res: driver.id,
      }
    } catch (e) {
      throw new InternalServerErrorException(e)
    }
  }

  async updateOrderSetting(
    driverId: string,
    data: Prisma.driver_settingsUpdateInput,
  ) {
    try {
      const driver = await this.prismaService.driver_settings.update({
        where: {
          driver_id: driverId,
        },
        data: data,
      })
      return {
        message: 'OK',
        res: driver.id,
      }
    } catch (e) {
      throw new BadRequestException({ message: 'Bad Request' })
    }
  }

  async saveDeviceToken(driverId: string, token: string) {
    const deviceTokenExist =
      await this.prismaService.driver_device_token.findUnique({
        where: {
          driver_id: driverId,
        },
      })
    if (deviceTokenExist) {
      const deviceToken = await this.prismaService.driver_device_token.update({
        where: {
          driver_id: driverId,
        },
        data: {
          token: token,
        },
      })
      return {
        message: 'OK',
        res: deviceToken.id,
      }
    }
    const deviceToken = await this.prismaService.driver_device_token.create({
      data: {
        token: token,
        driver_id: driverId,
      },
    })
    return {
      message: 'OK',
      res: deviceToken.id,
    }
  }
}
