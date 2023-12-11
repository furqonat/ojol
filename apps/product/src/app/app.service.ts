import { Injectable } from '@nestjs/common'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'

@Injectable()
export class AppService {
  constructor(
    private readonly firebase: FirebaseService,
    private readonly prisma: PrismaService,
  ) {}

  async getProduct() {}
}
