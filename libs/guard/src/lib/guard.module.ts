import { Module } from '@nestjs/common'
import { RolesGuard } from './roles.guard'
import { APP_GUARD } from '@nestjs/core'
import { FirebaseService } from '@lugo/firebase'

@Module({
  controllers: [],
  providers: [
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
    FirebaseService,
  ],
})
export class GuardModule {}
