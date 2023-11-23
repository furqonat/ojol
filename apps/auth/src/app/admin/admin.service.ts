import { Injectable } from '@nestjs/common'
import { JwtService } from '@nestjs/jwt'
import { BcryptService } from '@lugo/bcrypt'
import { UsersPrismaService } from '@lugo/users'
import { Role } from '@lugo/guard'
@Injectable()
export class AdminService {
  constructor(
    private readonly prismaService: UsersPrismaService,
    private readonly jwtService: JwtService,
    private readonly bcryptService: BcryptService,
  ) {}

  async signIn(email: string, password: string) {
    const admin = await this.prismaService.admin.findUnique({
      where: {
        email: email,
      },
    })

    if (admin) {
      const passwordValid = await this.bcryptService.comparePassword(
        password,
        admin.password,
      )
      if (passwordValid) {
        const payload = { sub: admin.id, email: admin.email, role: Role.ADMIN }
        return {
          message: 'OK',
          token: await this.jwtService.signAsync(payload),
        }
      } else {
        return {
          message: 'Invalid credential',
          token: null,
        }
      }
    } else {
      return {
        message: 'Invalid credential',
        token: null,
      }
    }
  }
}
