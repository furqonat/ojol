import { BcryptModule } from '@lugo/bcrypt'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { JwtModule } from '@nestjs/jwt'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      global: true,
    }),
    PrismaModule,
    BcryptModule,
  ],
  providers: [AdminService],
  controllers: [AdminController],
})
export class AdminModule {}
