import {
  Body,
  Controller,
  Headers,
  Post,
  UnauthorizedException,
} from '@nestjs/common'
import { MerchantService } from './merchant.service'

type BodyReq = {
  type: 'FOOD' | 'MART'
}

@Controller('merchant')
export class MerchantController {
  constructor(private readonly merchantService: MerchantService) {}

  @Post()
  async signIn(
    @Body() type: BodyReq,
    @Headers('Authorization') token?: string,
  ) {
    if (token) {
      return this.merchantService.signIn(token, type.type)
    } else {
      throw new UnauthorizedException()
    }
  }
}
