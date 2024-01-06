import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { DriverController } from './driver.controller'
import { DriverService } from './driver.service'

@Module({
  imports: [ConfigModule, FirebaseModule, PrismaModule],
  providers: [DriverService],
  controllers: [DriverController],
})
export class DriverModule {}
