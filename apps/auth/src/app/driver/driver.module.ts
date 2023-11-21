import { Module } from '@nestjs/common'
import { DriverService } from './driver.service'
import { DriverController } from './driver.controller'
import { FirebaseService } from '@lugo/firebase'
import { UsersPrismaService } from '@lugo/users'

@Module({
  providers: [DriverService, FirebaseService, UsersPrismaService],
  controllers: [DriverController],
})
export class DriverModule {}
