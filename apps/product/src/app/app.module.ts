import { Module } from '@nestjs/common'

import { AppController } from './app.controller'
import { AppService } from './app.service'
import { PrismaModule } from '@lugo/prisma'
import { FirebaseModule } from '@lugo/firebase'

@Module({
  imports: [PrismaModule, FirebaseModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
