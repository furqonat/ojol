import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
} from '@nestjs/common'
import { AdminService } from './admin.service'
import { Role, Roles } from '@lugo/jwtguard'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '../utility'

@Roles(Role.ADMIN, Role.SUPERADMIN)
@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

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

  @Post()
  async createAdmin(
    @Body() data: Prisma.adminCreateInput,
    @Body('roleId') roleId: string,
  ) {
    return this.adminService.createAmin(data, roleId)
  }

  @Get('customer')
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
  async deleteAdmin(@Param('id') adminId: string) {
    return this.adminService.deleteAdmin(adminId)
  }

  @Get(':id')
  async getAdmin(
    @Param('id') adminId: string,
    @Query() select?: Prisma.adminSelect,
  ) {
    return this.adminService.getAdmin(adminId, str2obj(select))
  }
}
