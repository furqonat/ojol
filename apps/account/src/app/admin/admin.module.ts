import { UsersPrismaService } from '@lugo/users'
import { Module } from '@nestjs/common'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'
import { FirebaseService } from '@lugo/firebase'

@Module({
  providers: [AdminService, UsersPrismaService, FirebaseService],
  controllers: [AdminController],
})
export class AdminModule {}
