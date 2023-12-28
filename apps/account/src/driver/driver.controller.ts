import { str2obj } from '@lugo/common'
import { Role, Roles, RolesGuard } from '@lugo/guard'
import {
  Body,
  Controller,
  Get,
  Post,
  Put,
  Query,
  Request,
  UnauthorizedException,
  UseGuards,
} from '@nestjs/common'
import { Prisma } from '@prisma/client/users'
import { DriverService } from './driver.service'
import { ApplyDriver } from '../dto/driver.dto'

@UseGuards(RolesGuard)
@Controller('driver')
export class DriverController {
  constructor(private readonly driverService: DriverService) {}

  @Roles(Role.DRIVER)
  @Get()
  async getDriver(
    @Request() req?: { uid?: string },
    @Query() select?: Prisma.driverSelect,
  ) {
    return this.driverService.getDriver(req.uid, str2obj(select))
  }

  @Roles(Role.DRIVER)
  @Post()
  async applyToBeDriver(
    @Request() req?: { uid?: string },
    @Body() details?: ApplyDriver,
  ) {
    return this.driverService.applyDriver(req.uid, {
      details: details.details,
      referal: details.referal,
    })
  }

  @Roles(Role.DRIVER)
  @Put()
  async updateApplyDriver(
    @Request() token: { uid?: string },
    @Body() data: Prisma.driver_detailsUpdateInput,
  ) {
    return this.driverService.updateDriverDetail(token.uid, data)
  }

  @Roles(Role.DRIVER)
  @Post('/token')
  async addOrEditDeviceToken(
    @Body('token') token: string,
    @Request() req?: { uid?: string },
  ) {
    if (req?.uid) {
      return this.driverService.saveDeviceToken(req.uid, token)
    }
    throw new UnauthorizedException()
  }

  @Roles(Role.DRIVER)
  @Put('/setting')
  async updateDriverSetting(
    @Body() data: { isOnline: boolean; autoBid: boolean },
    @Request() token?: { uid?: string },
  ) {
    if (!token?.uid) {
      throw new UnauthorizedException()
    }
    return this.driverService.updateDriverSettings(
      token.uid,
      data.autoBid,
      data.isOnline,
    )
  }

  @Roles(Role.DRIVER)
  @Put('/setting/order')
  async updateOrderSetting(
    @Request() token: { uid?: string },
    @Body() data: Prisma.driver_settingsUpdateInput,
  ) {
    return this.driverService.updateOrderSetting(token.uid, data)
  }

  @Roles(Role.DRIVER)
  @Put('/setting/coordinate')
  async updateDriverCoordinate(
    @Body() data: { latitude: number; longitude: number },
    @Request() token?: { uid?: string },
  ) {
    if (!token?.uid) {
      throw new UnauthorizedException()
    }
    return this.driverService.updateCurrentLatLon(
      token.uid,
      data.latitude,
      data.longitude,
    )
  }
}
