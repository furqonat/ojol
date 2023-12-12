import { str2obj } from '@lugo/common'
import { Role, Roles, RolesGuard } from '@lugo/guard'
import {
  Body,
  Controller,
  Get,
  Headers,
  Post,
  Put,
  Query,
  UseGuards,
} from '@nestjs/common'
import { Prisma } from '@prisma/client/users'
import { DriverService } from './driver.service'

@UseGuards(RolesGuard)
@Controller('driver')
export class DriverController {
  constructor(private readonly driverService: DriverService) {}

  @Roles(Role.DRIVER)
  @Get()
  async getDriver(
    @Headers('Authorization') token?: string,
    @Query() select?: Prisma.driverSelect,
  ) {
    return this.driverService.getDriver(token, str2obj(select))
  }

  @Roles(Role.DRIVER)
  @Post()
  async applyToBeDriver(
    @Headers('Authorization') token?: string,
    @Body() details?: Prisma.driver_detailsCreateInput,
  ) {
    return this.driverService.applyDriver(token, { details: details })
  }

  @Roles(Role.DRIVER)
  @Put('/setting/order')
  async updateOrderSetting(
    @Headers('Authorization') token: string,
    @Body() data: Prisma.driver_settingsUpdateInput,
  ) {
    return this.driverService.updateOrderSetting(token, data)
  }
}
