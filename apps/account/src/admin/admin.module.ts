import { BcryptService } from '@lugo/bcrypt'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { JwtModule, JwtService } from '@nestjs/jwt'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      global: true,
    }),
  ],
  providers: [
    AdminService,
    JwtService,
    PrismaService,
    FirebaseService,
    ConfigService,
    BcryptService,
  ],
  controllers: [AdminController],
})
export class AdminModule {}
