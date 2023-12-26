import { Prisma, PrismaService } from '@lugo/prisma'
import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { AdminQueryDTO, CreateAdminDTO } from '../dto/admin.dto'
import { FirebaseService } from '@lugo/firebase'
import { BcryptService } from '@lugo/bcrypt'

@Injectable()
export class AdminService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebase: FirebaseService,
    private readonly bcrypt: BcryptService,
  ) {}

  async getAdmin(adminId: string, select?: Prisma.adminSelect) {
    return this.prismaService.admin.findUnique({
      where: {
        id: adminId,
      },
      select: select ? select : { id: true },
    })
  }

  async getAdmins(options?: AdminQueryDTO, select?: Prisma.adminSelect) {
    const { take = 20, skip = 0, query } = options
    return this.prismaService.admin.findMany({
      where: {
        name: query ?? undefined,
      },
      select: select ? select : { id: true },
      take: take ? Number(take) : 10,
      skip: skip ? Number(skip) : 0,
    })
  }

  async createAmin(data: CreateAdminDTO, roleId: string) {
    try {
      const admin = await this.prismaService.admin.create({
        data: {
          name: data.name,
          email: data.email,
          role: {
            connect: {
              id: roleId,
            },
          },
          password: await this.bcrypt.generateHashPassword(data.password),
        },
      })
      return {
        message: 'OK',
        res: admin.id,
      }
    } catch (e) {
      throw new BadRequestException({ message: e.toString() })
    }
  }

  async deleteAdmin(id: string) {
    return this.prismaService.admin.delete({
      where: {
        id: id,
      },
    })
  }

  async updateAdmin(id: string, data: Prisma.adminUpdateInput) {
    return this.prismaService.admin.update({
      where: {
        id: id,
      },
      data: data,
    })
  }

  async getRoles() {
    return this.prismaService.roles.findMany({
      select: {
        id: true,
        name: true,
      },
    })
  }

  async getCustomer(id: string, select?: Prisma.customerSelect) {
    try {
      const customer = await this.prismaService.customer.findUnique({
        where: {
          id: id,
        },
        select: select ? select : { id: true },
      })
      return customer
    } catch (e) {
      throw new NotFoundException({ message: 'User not found', error: e })
    }
  }

  async getCustomers(options: {
    take?: number
    skip?: number
    query?: string
    select?: Prisma.customerSelect
  }) {
    const { take = 20, skip = 0, query, select } = options
    return this.prismaService.customer.findMany({
      where: {
        name: query ? { contains: query } : undefined,
      },
      select: select ? select : { id: true },
      take: take ? Number(take) : 10,
      skip: skip ? Number(skip) : 0,
    })
  }

  async updateCustomer(id: string, data: Prisma.customerUpdateInput) {
    return this.prismaService.customer.update({
      where: {
        id: id,
      },
      data: data,
    })
  }

  async getDriver(id: string, select: Prisma.driverSelect) {
    try {
      const driver = await this.prismaService.driver.findUnique({
        where: {
          id: id,
        },
        select: select ? select : { id: true },
      })
      return driver
    } catch (e) {
      throw new NotFoundException({ message: 'Driver not found', error: e })
    }
  }

  async getDrivers(options: {
    take?: number
    skip?: number
    select?: Prisma.driverSelect
    where: Prisma.driverWhereInput
  }) {
    const { take, select, skip, where } = options
    return this.prismaService.driver.findMany({
      where: where,
      select: select,
      take: Number(take),
      skip: Number(skip),
    })
  }

  async updateDriver(id: string, data: Prisma.driverUpdateInput) {
    return this.prismaService.driver.update({
      where: {
        id: id,
      },
      data: data,
    })
  }

  async getMerchant(id: string, select: Prisma.merchantSelect) {
    try {
      const merchant = await this.prismaService.merchant.findUnique({
        where: {
          id: id,
        },
        select: select ? select : { id: true },
      })
      return merchant
    } catch (e) {
      throw new NotFoundException({ message: 'Merchant not found', error: e })
    }
  }

  async getMerchants(options: {
    take?: number
    skip?: number
    select?: Prisma.merchantSelect
    where: Prisma.merchantWhereInput
  }) {
    const { take, select, skip, where } = options
    return this.prismaService.merchant.findMany({
      where: where,
      select: select,
      take: Number(take),
      skip: Number(skip),
    })
  }

  async updateMerchant(id: string, data: Prisma.merchantUpdateInput) {
    return this.prismaService.merchant.update({
      where: {
        id: id,
      },
      data: data,
    })
  }

  async getRegistrations(take?: number, skip?: number) {
    const merchant = this.prismaService.merchant.findMany({
      where: {
        status: 'PROCESS',
      },
      select: {
        id: true,
        email: true,
        email_verified: true,
        phone: true,
        phone_verified: true,
        status: true,
        details: true,
      },
      take: take ? Number(take) : 20,
      skip: skip ? Number(skip) : 0,
    })
    const merchantCount = this.prismaService.merchant.count({
      where: {
        status: 'PROCESS',
      },
    })

    const driver = this.prismaService.driver.findMany({
      where: {
        status: 'PROCESS',
      },
      select: {
        id: true,
        email: true,
        email_verified: true,
        phone: true,
        phone_verified: true,
        status: true,
        driver_details: true,
      },
      take: take ? Number(take) : 20,
      skip: skip ? Number(skip) : 0,
    })
    const driverCount = this.prismaService.driver.count({
      where: {
        status: 'PROCESS',
      },
    })

    const [merchants, mCount, drivers, dCount] = await Promise.all([
      merchant,
      merchantCount,
      driver,
      driverCount,
    ])
    return {
      data: {
        merchant: merchants,
        driver: drivers,
      },
      total: {
        merchant: mCount,
        driver: dCount,
      },
    }
  }

  async applyDriver(driverId: string) {
    const device_tokens = await this.prismaService.driver_device_token.findMany(
      {
        where: {
          driver_id: driverId,
        },
      },
    )
    const driver = await this.prismaService.driver.update({
      where: {
        id: driverId,
      },
      data: {
        status: 'ACTIVE',
      },
    })
    const notification = {
      title: 'Permintaan menjadi driver lugo',
      body: `Selamat ${driver.name} kamu telah di setujui oleh lugo untuk menjadi driver`,
    }
    await this.firebase.messaging.sendEachForMulticast({
      notification: notification,
      android: {
        notification: notification,
        priority: 'high',
      },
      apns: {
        payload: {
          aps: {
            alert: notification,
          },
        },
      },
      tokens: device_tokens.map((it) => it.token),
    })
    return { message: 'OK' }
  }

  async applyMerchant(merchantId: string) {
    const device_tokens =
      await this.prismaService.merchant_device_token.findMany({
        where: {
          merchant_id: merchantId,
        },
      })
    const merchant = await this.prismaService.merchant.update({
      where: {
        id: merchantId,
      },
      data: {
        status: 'ACTIVE',
      },
    })
    const notification = {
      title: 'Permintaan menjadi merchant lugo',
      body: `Selamat ${merchant.name} kamu telah di setujui oleh lugo untuk menjadi merchant`,
    }
    await this.firebase.messaging.sendEachForMulticast({
      notification: notification,
      android: {
        notification: notification,
        priority: 'high',
      },
      apns: {
        payload: {
          aps: {
            alert: notification,
          },
        },
      },
      tokens: device_tokens.map((it) => it.token),
    })
    return { message: 'OK' }
  }
}
