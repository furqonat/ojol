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
import { CustomerBasicUpdate, CustomerQuery } from '../dto/customer.dto'
import { CustomerService } from './customer.service'

@UseGuards(RolesGuard)
@Controller('customer')
export class CustomerController {
  constructor(private readonly customerService: CustomerService) {}

  @Roles(Role.USER)
  @Get()
  async getCustomer(
    @Request() req?: { uid?: string },
    @Query() query?: CustomerQuery,
  ) {
    if (req?.uid) {
      return this.customerService.getCustomer(req.uid, str2obj(query))
    } else {
      throw new UnauthorizedException()
    }
  }

  @Roles(Role.USER)
  @Put()
  async basicUpdateCustomer(
    @Body() data: CustomerBasicUpdate,
    @Request() req?: { uid?: string },
  ) {
    if (req?.uid) {
      return this.customerService.basicUpdate(req.uid, data)
    } else {
      throw new UnauthorizedException()
    }
  }
  @Roles(Role.USER)
  @Post('/token')
  async addOrEditDeviceToken(
    @Body('token') token: string,
    @Request() req?: { uid?: string },
  ) {
    if (req?.uid) {
      return this.customerService.saveDeviceToken(req.uid, token)
    }
    throw new UnauthorizedException()
  }
}
