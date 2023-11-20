import { Module } from '@nestjs/common'
import { DriverService } from './driver.service'
import { DriverController } from './driver.controller'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '../prisma/prisma.service'

@Module({
  providers: [DriverService, FirebaseService, PrismaService],
  controllers: [DriverController],
})
export class DriverModule {}
