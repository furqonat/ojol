import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common'
import { Reflector } from '@nestjs/core'
import { JwtService } from '@nestjs/jwt'
import { Request } from 'express'
import { ROLE_KEY } from './roles.decorator'
import { Role } from './roles.enum'

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private readonly jwtService: JwtService,
  ) {}

  async canActivate(context: ExecutionContext) {
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLE_KEY, [
      context.getHandler(),
      context.getClass(),
    ])
    if (!requiredRoles) {
      return true
    }
    const request = context.switchToHttp().getRequest()
    const token = this.extractBearerTokenFromHeader(request)
    if (!token) {
      return false
    }
    try {
      const userDecode = await this.jwtService.verifyAsync(token)
      const roles = userDecode['role'] as
        | [{ id: string; name: string }]
        | null
        | undefined
      if (roles) {
        return requiredRoles.some((role) => {
          return roles.some((decodedRole) => decodedRole.name === role)
        })
      } else {
        return false
      }
    } catch (error) {
      throw new UnauthorizedException(error)
    }
  }

  private extractBearerTokenFromHeader(request: Request): string | undefined {
    const token = request.headers.authorization?.split(' ')
    if (token) {
      return token[1]
    }
    return undefined
  }
}
