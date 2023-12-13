import { FirebaseModule, FirebaseService } from '@lugo/firebase'
import { Module } from '@nestjs/common'
import { APP_GUARD } from '@nestjs/core'
import { RolesGuard } from './roles.guard'

@Module({
  imports: [FirebaseModule],
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
