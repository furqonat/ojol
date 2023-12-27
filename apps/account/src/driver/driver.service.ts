import { FirebaseService } from '@lugo/firebase'
import { Prisma, PrismaService } from '@lugo/prisma'
import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common'

@Injectable()
export class DriverService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebase: FirebaseService,
  ) {}

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
      await this.firebase.firestore.collection('drivers').doc(driverId).create({
        isOnline: createDetail.is_online,
        address: createDetail.driver_details.address,
        latitude: createDetail.driver_details.current_lat,
        longitude: createDetail.driver_details.current_lng,
        name: createDetail.name,
        type: createDetail.driver_details.driver_type,
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

  async updateDriverSettings(
    driverId: string,
    autoBid?: boolean,
    isOnline?: boolean,
  ) {
    try {
      const driver = await this.prismaService.driver.update({
        where: {
          id: driverId,
        },
        data: {
          is_online: isOnline ?? undefined,
          driver_settings: {
            update: {
              where: {
                driver_id: driverId,
              },
              data: {
                auto_bid: autoBid ?? undefined,
              },
            },
          },
        },
      })
      const frs = await this.firebase.firestore
        .collection('drivers')
        .doc(driver.id)
        .update({
          isOnline: isOnline ?? undefined,
        })
      return {
        message: 'OK',
        res: driver.id + frs.writeTime,
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

  async updateCurrentLatLon(
    driverId: string,
    latitude: number,
    longitude: number,
  ) {
    try {
      const driver = await this.prismaService.driver.update({
        where: {
          id: driverId,
        },
        data: {
          driver_details: {
            update: {
              where: {
                driver_id: driverId,
              },
              data: {
                current_lat: latitude,
                current_lng: longitude,
              },
            },
          },
        },
      })
      const frs = await this.firebase.firestore
        .collection('drivers')
        .doc(driver.id)
        .update({
          latitude: latitude,
          longitude: longitude,
        })
      return {
        message: 'OK',
        res: driver.id + frs.writeTime,
      }
    } catch (e) {
      throw new InternalServerErrorException(e)
    }
  }
}
