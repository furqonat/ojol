import {
  Controller,
  Headers,
  Post,
  UnauthorizedException,
} from '@nestjs/common'
import { MerchantService } from './merchant.service'

@Controller('merchant')
export class MerchantController {
  constructor(private readonly merchantService: MerchantService) {}

  @Post()
  async signIn(@Headers('Authorization') token?: string) {
    if (token) {
      return this.merchantService.signIn(token)
    } else {
      throw new UnauthorizedException()
    }
  }
}
