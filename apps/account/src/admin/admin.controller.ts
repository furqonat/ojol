import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common'
import { AdminService } from './admin.service'
import { Role, Roles, RolesGuard } from '@lugo/jwtguard'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '@lugo/common'

@UseGuards(RolesGuard)
@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Get()
  @Roles(Role.ADMIN, Role.SUPERADMIN)
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

  @Post()
  @Roles(Role.SUPERADMIN)
  async createAdmin(
    @Body() data: Prisma.adminCreateInput,
    @Body('roleId') roleId: string,
  ) {
    return this.adminService.createAmin(data, roleId)
  }

  @Get('customer')
  @Roles(Role.ADMIN, Role.SUPERADMIN)
  async getCustomers(
    @Query('take') take?: number,
    @Query('skip') skip?: number,
    @Query('query') query?: string,
    @Query() select?: Prisma.customerSelect,
  ) {
    return this.adminService.getCustomers({
      take: take,
      skip: skip,
      query: query,
      select: str2obj(select),
    })
  }

  @Delete(':id')
  @Roles(Role.SUPERADMIN)
  async deleteAdmin(@Param('id') adminId: string) {
    return this.adminService.deleteAdmin(adminId)
  }

  @Get(':id')
  @Roles(Role.ADMIN, Role.SUPERADMIN)
  async getAdmin(
    @Param('id') adminId: string,
    @Query() select?: Prisma.adminSelect,
  ) {
    return this.adminService.getAdmin(adminId, str2obj(select))
  }
}
