import { BcryptModule, BcryptService } from '@lugo/bcrypt'
import { Module } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
import { PrismaModule } from '../prisma/prisma.module'
import { PrismaService } from '../prisma/prisma.service'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'

@Module({
  imports: [BcryptModule, PrismaModule],
  providers: [AdminService, JwtService, PrismaService, BcryptService],
  controllers: [AdminController],
})
export class AdminModule {}
