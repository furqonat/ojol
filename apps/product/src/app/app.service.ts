import { Injectable } from '@nestjs/common'
import { FirebaseService } from '@lugo/firebase'
import { UsersPrismaService } from '@lugo/users'

@Injectable()
export class AppService {
  constructor(
    private readonly firebase: FirebaseService,
    private readonly prisma: UsersPrismaService,
  ) {}

  async getProduct() {}
}
