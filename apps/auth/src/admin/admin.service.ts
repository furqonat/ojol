import { BcryptService } from '@lugo/bcrypt'
import { UsersPrismaService } from '@lugo/users'
import { BadRequestException, Injectable } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
@Injectable()
export class AdminService {
  constructor(
    private readonly prismaService: UsersPrismaService,
    private readonly bcryptService: BcryptService,
    private readonly jwtService: JwtService,
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
        status: true,
      },
    })

    if (admin) {
      const passwordValid = await this.bcryptService.comparePassword(
        password,
        admin.password,
      )
      if (passwordValid) {
        const payload = {
          id: admin.id,
          name: admin.name,
          role: admin.role,
        }
        return {
          id: admin.id,
          name: admin.name,
          email: admin.email,
          role: admin.role,
          avatar: admin.avatar,
          status: admin.status,
          token: this.jwtService.sign(payload),
        }
      } else {
        throw new BadRequestException({ message: 'Invalid credential' })
      }
    } else {
      throw new BadRequestException({ message: 'Invalid credential' })
    }
  }
}
