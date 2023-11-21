import { BcryptModule, BcryptService } from '@lugo/bcrypt'
import { Module } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'
import { UsersPrismaService } from '@lugo/users'

@Module({
  imports: [BcryptModule],
  providers: [AdminService, JwtService, UsersPrismaService, BcryptService],
  controllers: [AdminController],
})
export class AdminModule {}
