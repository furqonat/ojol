import {
  Body,
  Controller,
  Get,
  Headers,
  Put,
  Query,
  UnauthorizedException,
} from '@nestjs/common'
import { CustomerBasicUpdate, CustomerQuery } from '../dto/customer.dto'
import { CustomerService } from './customer.service'

@Controller('customer')
export class CustomerController {
  constructor(private readonly customerService: CustomerService) {}

  @Get()
  async getCustomer(
    @Headers('Authorization') token?: string,
    @Query() query?: CustomerQuery,
  ) {
    if (token) {
      return this.customerService.getCustomer(token, query)
    } else {
      throw new UnauthorizedException()
    }
  }

  @Put()
  async basicUpdateCustomer(
    @Body() data: CustomerBasicUpdate,
    @Headers('Authorization') token?: string,
  ) {
    if (token) {
      return this.customerService.basicUpdate(token, data)
    } else {
      throw new UnauthorizedException()
    }
  }
}
