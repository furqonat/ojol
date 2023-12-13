import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Module } from '@nestjs/common'
import { DriverController } from './driver.controller'
import { DriverService } from './driver.service'
import { FirebaseModule } from '@lugo/firebase'

@Module({
  imports: [PrismaModule, FirebaseModule, GuardModule],
  providers: [DriverService],
  controllers: [DriverController],
})
export class DriverModule {}
