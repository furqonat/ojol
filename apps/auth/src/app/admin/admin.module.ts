import { BcryptModule, BcryptService } from '@lugo/bcrypt'
import { UsersPrismaService } from '@lugo/users'
import { Module } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'

@Module({
  imports: [BcryptModule],
  providers: [AdminService, UsersPrismaService, BcryptService, JwtService],
  controllers: [AdminController],
})
export class AdminModule {}
