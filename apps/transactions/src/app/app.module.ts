import { Module } from '@nestjs/common'
import { RideModule } from './ride/ride.module'
import { MartModule } from './mart/mart.module'

@Module({
  imports: [RideModule, MartModule],
})
export class AppModule {}
