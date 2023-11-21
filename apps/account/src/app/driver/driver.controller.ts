import { Body, Controller, Get, Headers, Post, Query } from '@nestjs/common'
import { DriverService } from './driver.service'
import { Prisma } from '@prisma/client/users'

@Controller('driver')
export class DriverController {
  constructor(private readonly driverService: DriverService) {}

  @Get()
  async getDriver(
    @Headers('Authorization') token?: string,
    @Query() select?: Prisma.driverSelect,
  ) {
    return this.driverService.getDriver(token, select)
  }

  @Post()
  async applyToBeDriver(
    @Headers('Authorization') token?: string,
    @Body() details?: Prisma.driver_detailsCreateInput,
  ) {
    return this.driverService.applyDriver(token, { details: details })
  }
}
