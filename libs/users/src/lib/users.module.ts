import { Module } from '@nestjs/common'
import { UsersPrismaService } from './users-prisma.service'

@Module({
  controllers: [],
  providers: [UsersPrismaService],
  exports: [UsersPrismaService],
})
export class UsersModule {}
