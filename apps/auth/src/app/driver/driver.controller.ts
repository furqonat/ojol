import {
  Controller,
  Headers,
  Post,
  UnauthorizedException,
} from '@nestjs/common'
import { DriverService } from './driver.service'

@Controller('driver')
export class DriverController {
  constructor(private readonly driverService: DriverService) {}

  @Post()
  async signIn(@Headers('Authorization') token?: string) {
    if (token) {
      return this.driverService.signIn(token)
    } else {
      throw new UnauthorizedException()
    }
  }
}
