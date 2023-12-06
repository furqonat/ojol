import { Module } from '@nestjs/common'
import { DriverService } from './driver.service'
import { DriverController } from './driver.controller'
import { UsersPrismaService } from '@lugo/users'
import { FirebaseService } from '@lugo/firebase'

@Module({
  providers: [DriverService, UsersPrismaService, FirebaseService],
  controllers: [DriverController],
})
export class DriverModule {}
