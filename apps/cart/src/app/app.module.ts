import { Module } from '@nestjs/common'

import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { FirebaseModule } from '@lugo/firebase'

@Module({
  imports: [GuardModule, PrismaModule, FirebaseModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
