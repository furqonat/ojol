import { Module } from '@nestjs/common'

import { GuardModule } from '@lugo/guard'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { FirebaseModule } from '@lugo/firebase'
import { PrismaModule } from '@lugo/prisma'

@Module({
  imports: [GuardModule, FirebaseModule, PrismaModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
