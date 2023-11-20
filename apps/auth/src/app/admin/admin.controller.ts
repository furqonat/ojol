import { BadRequestException, Body, Controller, Post } from '@nestjs/common'
import { AdminService } from './admin.service'

type SignInDto = {
  email: string
  password: string
}

@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Post()
  async signIn(@Body() signInDto: SignInDto) {
    if (!signInDto.email || !signInDto.password) {
      return new BadRequestException()
    }
    return this.adminService.signIn(signInDto.email, signInDto.password)
  }
}
