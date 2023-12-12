import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import { DriverController } from './driver.controller'
import { DriverService } from './driver.service'
import { GuardModule } from '@lugo/guard'

@Module({
  imports: [ConfigModule, PrismaModule, FirebaseModule, GuardModule],
  providers: [DriverService],
  controllers: [DriverController],
})
export class DriverModule {}
