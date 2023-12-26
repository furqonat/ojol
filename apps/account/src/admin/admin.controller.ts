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
    @Query() select?: Prisma.customerSelect,
  ) {
    return this.adminService.getCustomers({
      take: take,
      skip: skip,
      query: query,
      select: str2obj(select),
    })
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

  @Put('"id')
  @Roles(Role.SUPERADMIN, Role.ADMIN)
  async updateAdmin(
    @Param('id') adminId: string,
    @Body() data: Prisma.adminUpdateInput,
  ) {
    return this.adminService.updateAdmin(adminId, data)
  }
}
