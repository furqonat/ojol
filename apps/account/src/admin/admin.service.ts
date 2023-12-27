import { Prisma, PrismaService } from '@lugo/prisma'
import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { AdminQueryDTO, CreateAdminDTO } from '../dto/admin.dto'
import { FirebaseService } from '@lugo/firebase'
import { BcryptService } from '@lugo/bcrypt'

const today = new Date()
const startOfDay = new Date(
  today.getFullYear(),
  today.getMonth(),
  today.getDate(),
)
const endOfDay = new Date(
  today.getFullYear(),
  today.getMonth(),
  today.getDate() + 1,
)

const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1)
const endOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 1)

const startOfYear = new Date(today.getFullYear(), 0, 1)
const endOfYear = new Date(today.getFullYear() + 1, 0, 1)

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
    createdIn?: 'day' | 'month' | 'year'
  }) {
    const { take = 20, skip = 0, query, select, createdIn } = options

    const customers = await this.prismaService.customer.findMany({
      where: {
        name: query ? { contains: query } : undefined,
        created_at: createdIn
          ? {
              gte:
                createdIn === 'day'
                  ? startOfDay
                  : createdIn === 'month'
                    ? startOfMonth
                    : startOfYear,
              lt:
                createdIn === 'day'
                  ? endOfDay
                  : createdIn === 'month'
                    ? endOfMonth
                    : endOfYear,
            }
          : undefined,
      },
      select: select ? select : { id: true },
      take: take ? Number(take) : 10,
      skip: skip ? Number(skip) : 0,
    })
    const total = await this.prismaService.customer.count({
      where: {
        name: query ? { contains: query } : undefined,
        created_at: createdIn
          ? {
              gte:
                createdIn === 'day'
                  ? startOfDay
                  : createdIn === 'month'
                    ? startOfMonth
                    : startOfYear,
              lt:
                createdIn === 'day'
                  ? endOfDay
                  : createdIn === 'month'
                    ? endOfMonth
                    : endOfYear,
            }
          : undefined,
      },
    })
    return {
      data: customers,
      total: total,
    }
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
    isOnline?: boolean
    status?: Prisma.Enumdriver_statusFilter
    query?: string
    orderBy?: 'name' | 'order'
    createdIn?: 'day' | 'month' | 'year'
  }) {
    const { take, select, skip, isOnline, status, query, orderBy, createdIn } =
      options
    const drivers = await this.prismaService.driver.findMany({
      where: {
        is_online: isOnline ?? undefined,
        status: status ?? undefined,
        name: query
          ? {
              contains: query,
            }
          : undefined,
        created_at: createdIn
          ? {
              gte:
                createdIn === 'day'
                  ? startOfDay
                  : createdIn === 'month'
                    ? startOfMonth
                    : startOfYear,
              lt:
                createdIn === 'day'
                  ? endOfDay
                  : createdIn === 'month'
                    ? endOfMonth
                    : endOfYear,
            }
          : undefined,
      },
      select: select ? select : { id: true },
      take: take ? Number(take) : 20,
      skip: skip ? Number(skip) : 0,
      orderBy: orderBy
        ? orderBy == 'order'
          ? {
              order: {
                _count: 'desc',
              },
            }
          : {
              name: 'desc',
            }
        : undefined,
    })
    const total = await this.prismaService.driver.findMany({
      where: {
        is_online: isOnline ?? undefined,
        status: status ?? undefined,
        name: query
          ? {
              contains: query,
            }
          : undefined,
        created_at: createdIn
          ? {
              gte:
                createdIn === 'day'
                  ? startOfDay
                  : createdIn === 'month'
                    ? startOfMonth
                    : startOfYear,
              lt:
                createdIn === 'day'
                  ? endOfDay
                  : createdIn === 'month'
                    ? endOfMonth
                    : endOfYear,
            }
          : undefined,
      },
    })
    return {
      data: drivers,
      total: total,
    }
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
    query?: string
    type?: Prisma.Enummerchant_typeFilter
    status?: Prisma.Enummerchant_statusFilter
    orderBy?: 'name' | 'active'
    createdIn?: 'day' | 'month' | 'year'
  }) {
    const { take, select, skip, query, type, status, orderBy, createdIn } =
      options
    const merchants = await this.prismaService.merchant.findMany({
      where: {
        type: type ?? undefined,
        status: status ?? undefined,
        name: query
          ? {
              contains: query,
            }
          : undefined,
        created_at: createdIn
          ? {
              gte:
                createdIn === 'day'
                  ? startOfDay
                  : createdIn === 'month'
                    ? startOfMonth
                    : startOfYear,
              lt:
                createdIn === 'day'
                  ? endOfDay
                  : createdIn === 'month'
                    ? endOfMonth
                    : endOfYear,
            }
          : undefined,
      },
      select: select,
      take: take ? Number(take) : 20,
      skip: skip ? Number(skip) : 0,
      orderBy: orderBy
        ? orderBy === 'active'
          ? {
              last_active: 'desc',
            }
          : {
              name: 'desc',
            }
        : undefined,
    })
    const total = await this.prismaService.merchant.count({
      where: {
        type: type ?? undefined,
        status: status ?? undefined,
        name: query
          ? {
              contains: query,
            }
          : undefined,
        created_at: createdIn
          ? {
              gte:
                createdIn === 'day'
                  ? startOfDay
                  : createdIn === 'month'
                    ? startOfMonth
                    : startOfYear,
              lt:
                createdIn === 'day'
                  ? endOfDay
                  : createdIn === 'month'
                    ? endOfMonth
                    : endOfYear,
            }
          : undefined,
      },
    })

    return {
      data: merchants,
      total: total,
    }
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
