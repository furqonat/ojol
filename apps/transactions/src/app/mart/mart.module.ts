import { Module } from '@nestjs/common'
import { MartService } from './mart.service'
import { MartController } from './mart.controller'

@Module({
  providers: [MartService],
  controllers: [MartController],
})
export class MartModule {}
