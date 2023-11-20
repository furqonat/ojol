import { Module } from '@nestjs/common'
import { AdminService } from './admin.service'
import { AdminController } from './admin.controller'
import { JwtModule, JwtService } from '@nestjs/jwt'
import { PrismaService } from '../prisma/prisma.service'
import { BcryptModule, BcryptService } from '@lugo/bcrypt'
import { PrismaModule } from '../prisma/prisma.module'

@Module({
  imports: [
    BcryptModule,
    PrismaModule,
    JwtModule.register({
      secret: '',
    }),
  ],
  providers: [AdminService, JwtService, PrismaService, BcryptService],
  controllers: [AdminController],
})
export class AdminModule {}
