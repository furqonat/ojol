import {
  Body,
  Controller,
  Get,
  Headers,
  Post,
  Put,
  Query,
} from '@nestjs/common'
import { DriverService } from './driver.service'
import { Prisma } from '@prisma/client/users'
import { str2obj } from '../utility'

@Controller('driver')
export class DriverController {
  constructor(private readonly driverService: DriverService) {}

  @Get()
  async getDriver(
    @Headers('Authorization') token?: string,
    @Query() select?: Prisma.driverSelect,
  ) {
    return this.driverService.getDriver(token, str2obj(select))
  }

  @Post()
  async applyToBeDriver(
    @Headers('Authorization') token?: string,
    @Body() details?: Prisma.driver_detailsCreateInput,
  ) {
    return this.driverService.applyDriver(token, { details: details })
  }

  @Put('/setting/order')
  async updateOrderSetting(
    @Headers('Authorization') token: string,
    @Body() data: Prisma.driver_settingsUpdateInput,
  ) {
    return this.driverService.updateOrderSetting(token, data)
  }
}
