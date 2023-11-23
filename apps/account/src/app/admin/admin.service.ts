import { Prisma, UsersPrismaService } from '@lugo/users'
import { Injectable, NotFoundException } from '@nestjs/common'
import { AdminQueryDTO } from '../dto/admin.dto'

@Injectable()
export class AdminService {
  constructor(private readonly prismaService: UsersPrismaService) {}

  async getAdmin(adminId: string) {
    return this.prismaService.admin.findUnique({
      where: {
        id: adminId,
      },
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
    console.log(select)
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
}
