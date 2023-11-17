import {
  Controller,
  Headers,
  Post,
  UnauthorizedException,
} from '@nestjs/common'
import { CustomerService } from './customer.service'

@Controller('customer')
export class CustomerController {
  constructor(private readonly customerService: CustomerService) {}

  @Post()
  async signIn(@Headers('Authorization') token?: string) {
    if (token) return this.customerService.signIn(token)
    throw new UnauthorizedException()
  }
}
