import {
  CanActivate,
  ExecutionContext,
  Injectable,
  Logger,
} from '@nestjs/common'
import { Reflector } from '@nestjs/core'
import { Role } from './roles.enum'
import { Request } from 'express'
import { ROLE_KEY } from './roles.decorator'
import { getAuth } from 'firebase-admin/auth'

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  async canActivate(context: ExecutionContext) {
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLE_KEY, [
      context.getHandler(),
      context.getClass(),
    ])
    Logger.log('Required roles', `${requiredRoles}`)
    if (!requiredRoles) {
      return true
    }
    const request = context.switchToHttp().getRequest()
    const token = this.extractBearerTokenFromHeader(request)
    if (!token) {
      return false
    }
    try {
      const userDecode = await getAuth()?.verifyIdToken(token)
      return requiredRoles.includes(userDecode['roles'])
    } catch (error) {
      Logger.error(
        'Did you forgot initialize Firebase Admin SDK?',
        error,
        'RolesGuard',
      )
      return false
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
