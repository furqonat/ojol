import { Module } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
import { RolesGuard } from './roles.guard'
import { ConfigModule } from '@nestjs/config'

const JWT_GUARD = 'JWT_GUARD'

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
  ],
  controllers: [],
  providers: [
    {
      provide: JWT_GUARD,
      useClass: RolesGuard,
    },
    JwtService,
  ],
  exports: [],
})
export class JwtGuardModule {}
