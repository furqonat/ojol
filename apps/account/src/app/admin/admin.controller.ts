import { Controller, Get, Query } from '@nestjs/common'
import { AdminService } from './admin.service'
// import { Role, Roles } from '@lugo/guard'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '../utility'

// @Roles(Role.ADMIN)
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
}
