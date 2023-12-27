import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  UseGuards,
} from '@nestjs/common'
import { AdminService } from './admin.service'
import { Role, Roles, RolesGuard } from '@lugo/jwtguard'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '@lugo/common'
import { CreateAdminDTO } from '../dto/admin.dto'

@UseGuards(RolesGuard)
@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Roles(Role.ADMIN, Role.SUPERADMIN)
  @Get()
  async getAdmins(
    @Query('take') take?: number,
    @Query('skip') skip?: number,
    @Query('query') query?: string,
    @Query() select?: Prisma.adminSelect,
  ) {
    return this.adminService.getAdmins(
      { take: take, skip: skip, query: query },
      str2obj(select),
    )
  }
  @Roles(Role.ADMIN, Role.SUPERADMIN)
  @Get('roles')
  async getRoles() {
    return this.adminService.getRoles()
  }

  @Post()
  @Roles(Role.SUPERADMIN)
  async createAdmin(@Body() data: CreateAdminDTO) {
    return this.adminService.createAmin(data, data.roleId)
  }

  @Roles(Role.ADMIN, Role.SUPERADMIN)
  @Get('customer')
  async getCustomers(
    @Query('take') take?: number,
    @Query('skip') skip?: number,
    @Query('query') query?: string,
    @Query('createdIn') createdIn?: 'day' | 'month' | 'year',
    @Query() select?: Prisma.customerSelect,
  ) {
    return this.adminService.getCustomers({
      take: take,
      skip: skip,
      query: query,
      select: str2obj(select),
      createdIn: createdIn,
    })
  }

  @Roles(Role.SUPERADMIN, Role.ADMIN)
  @Get('driver')
  async getDrivers(
    @Query('take') take?: number,
    @Query('skip') skip?: number,
    @Query('query') query?: string,
    @Query('online') online?: boolean,
    @Query('type') type?: Prisma.Enumdriver_statusFilter,
    @Query('orderBy') orderBy?: 'name' | 'order',
    @Query() select?: Prisma.driverSelect,
    @Query('createdIn') createdIn?: 'day' | 'month' | 'year',
  ) {
    return this.adminService.getDrivers({
      take: take,
      skip: skip,
      query: query,
      isOnline: online,
      status: type,
      select: select,
      orderBy: orderBy,
      createdIn: createdIn,
    })
  }

  @Roles(Role.SUPERADMIN, Role.ADMIN)
  @Get('merchant')
  async getMerchants(
    @Query('take') take?: number,
    @Query('skip') skip?: number,
    @Query('query') query?: string,
    @Query('mType') type?: Prisma.Enummerchant_typeFilter,
    @Query('mStatus') status?: Prisma.Enummerchant_statusFilter,
    @Query('orderBy') orderby?: 'name' | 'active',
    @Query() select?: Prisma.merchantSelect,
    @Query('createdIn') createdIn?: 'day' | 'month' | 'year',
  ) {
    return this.adminService.getMerchants({
      take: take,
      skip: skip,
      query: query,
      type: type,
      status: status,
      orderBy: orderby,
      select: select,
      createdIn: createdIn,
    })
  }

  @Roles(Role.ADMIN, Role.SUPERADMIN)
  @Get('customer/:id')
  async getCustomer(
    @Param('id') customerId: string,
    @Query() select: Prisma.customerSelect,
  ) {
    return this.adminService.getCustomer(customerId, select)
  }

  @Roles(Role.SUPERADMIN)
  @Put('customer/:id')
  async updateCustomer(
    @Param('id') customerId: string,
    @Body() data: Prisma.customerUpdateInput,
  ) {
    return this.adminService.updateCustomer(customerId, data)
  }

  @Roles(Role.SUPERADMIN, Role.ADMIN)
  @Get('driver/:id')
  async getDriver(
    @Param('id') driverId: string,
    @Query() select: Prisma.driverSelect,
  ) {
    return this.adminService.getDriver(driverId, select)
  }

  @Roles(Role.SUPERADMIN)
  @Put('driver/:id')
  async updateDriver(
    @Param('id') driverId: string,
    @Body() data: Prisma.driverUpdateInput,
  ) {
    return this.adminService.updateDriver(driverId, data)
  }

  @Roles(Role.ADMIN, Role.SUPERADMIN)
  @Get('merchant/:id')
  async getMerchant(
    @Param('id') merchantId: string,
    @Query() select?: Prisma.merchantSelect,
  ) {
    return this.adminService.getMerchant(merchantId, select)
  }

  @Roles(Role.SUPERADMIN)
  @Put('merchant/:id')
  async updateMerchant(
    @Param('id') merchantId: string,
    @Body() data: Prisma.merchantUpdateInput,
  ) {
    return this.adminService.updateMerchant(merchantId, data)
  }
  @Roles(Role.SUPERADMIN)
  @Delete(':id')
  async deleteAdmin(@Param('id') adminId: string) {
    return this.adminService.deleteAdmin(adminId)
  }

  @Roles(Role.ADMIN, Role.SUPERADMIN)
  @Get(':id')
  async getAdmin(
    @Param('id') adminId: string,
    @Query() select?: Prisma.adminSelect,
  ) {
    return this.adminService.getAdmin(adminId, str2obj(select))
  }

  @Put(':id')
  @Roles(Role.SUPERADMIN, Role.ADMIN)
  async updateAdmin(
    @Param('id') adminId: string,
    @Body() data: Prisma.adminUpdateInput,
  ) {
    return this.adminService.updateAdmin(adminId, data)
  }
}
