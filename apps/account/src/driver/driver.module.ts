import { Module } from '@nestjs/common'
import { DriverService } from './driver.service'
import { DriverController } from './driver.controller'
import { PrismaService } from '@lugo/prisma'
import { FirebaseService } from '@lugo/firebase'

@Module({
  providers: [DriverService, PrismaService, FirebaseService],
  controllers: [DriverController],
})
export class DriverModule {}
