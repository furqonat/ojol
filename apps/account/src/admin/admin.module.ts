import { BcryptModule } from '@lugo/bcrypt'
import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { JwtModule } from '@nestjs/jwt'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'
import { JwtGuardModule } from '@lugo/jwtguard'

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      global: true,
    }),
    ConfigModule,
    PrismaModule,
    FirebaseModule,
    BcryptModule,
    JwtGuardModule,
  ],
  providers: [AdminService],
  controllers: [AdminController],
})
export class AdminModule {}
