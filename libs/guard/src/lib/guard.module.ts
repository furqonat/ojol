import { FirebaseModule, FirebaseService } from '@lugo/firebase'
import { Module } from '@nestjs/common'
import { RolesGuard } from './roles.guard'

const FIREBASE_GUARD = 'FIREBASE_GUARD'
@Module({
  imports: [FirebaseModule],
  controllers: [],
  providers: [
    {
      provide: FIREBASE_GUARD,
      useClass: RolesGuard,
    },
    FirebaseService,
  ],
})
export class GuardModule {}
