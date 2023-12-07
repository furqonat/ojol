import { Module } from '@nestjs/common'

import { GuardModule } from '@lugo/guard'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { FirebaseModule } from '@lugo/firebase'
import { UsersModule } from '@lugo/users'

@Module({
  imports: [GuardModule, FirebaseModule, UsersModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
