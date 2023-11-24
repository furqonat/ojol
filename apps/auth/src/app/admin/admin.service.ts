import { BcryptService } from '@lugo/bcrypt'
import { UsersPrismaService } from '@lugo/users'
import { BadRequestException, Injectable } from '@nestjs/common'
@Injectable()
export class AdminService {
  constructor(
    private readonly prismaService: UsersPrismaService,
    private readonly bcryptService: BcryptService,
  ) {}

  async signIn(email: string, password: string) {
    const admin = await this.prismaService.admin.findUnique({
      where: {
        email: email,
      },
      select: {
        password: true,
        id: true,
        name: true,
        avatar: true,
        role: true,
        email: true,
      },
    })

    if (admin) {
      const passwordValid = await this.bcryptService.comparePassword(
        password,
        admin.password,
      )
      if (passwordValid) {
        return {
          id: admin.id,
          name: admin.name,
          email: admin.email,
          role: admin.role,
          avatar: admin.avatar,
        }
      } else {
        throw new BadRequestException({ message: 'Invalid credential' })
      }
    } else {
      throw new BadRequestException({ message: 'Invalid credential' })
    }
  }
}
