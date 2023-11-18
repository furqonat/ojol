import { PrismaService } from '../prisma/prisma.service'
import { Injectable } from '@nestjs/common'

@Injectable()
export class AdminService {
  constructor(private readonly prismaService: PrismaService) {}

  async signIn(email: string, password: string) {
    const admin = await this.prismaService.admin.findUnique({
      where: {
        email: email,
      },
    })
    if (admin) {
      //
    } else {
      return {
        message: 'Invalid credential',
        token: null,
      }
    }
  }
}
