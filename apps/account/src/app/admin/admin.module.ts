import { UsersPrismaService } from '@lugo/users'
import { Module } from '@nestjs/common'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

@Module({
  providers: [AdminService, UsersPrismaService, FirebaseService, ConfigService],
  controllers: [AdminController],
})
export class AdminModule {}
