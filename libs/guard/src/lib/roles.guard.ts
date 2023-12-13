import {
  CanActivate,
  ExecutionContext,
  Injectable,
  InternalServerErrorException,
  Logger,
  UnauthorizedException,
} from '@nestjs/common'
import { Reflector } from '@nestjs/core'
import { Role } from './roles.enum'
import { Request } from 'express'
import { ROLE_KEY } from './roles.decorator'
import { FirebaseService } from '@lugo/firebase'

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private readonly firebase: FirebaseService,
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
      const userDecode = await this.firebase.auth?.verifyIdToken(token)
      const rolesValid = requiredRoles.includes(userDecode['roles'])
      if (rolesValid) {
        request['uid'] = userDecode.uid
        return rolesValid
      } else {
        throw new UnauthorizedException()
      }
    } catch (error) {
      Logger.error(
        'Did you forgot initialize Firebase Admin SDK?',
        error,
        'RolesGuard',
      )
      throw new InternalServerErrorException(error)
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
