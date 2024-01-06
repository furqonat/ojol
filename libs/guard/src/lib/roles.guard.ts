import { FirebaseService } from '@lugo/firebase'
import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common'
import { Reflector } from '@nestjs/core'
import { Request } from 'express'
import { ROLE_KEY } from './roles.decorator'
import { Role } from './roles.enum'

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
    const userDecode = await this.firebase.auth?.verifyIdToken(token)
    const rolesValid = requiredRoles.includes(userDecode['roles'])
    if (rolesValid) {
      request['uid'] = userDecode.uid
      return rolesValid
    } else {
      throw new UnauthorizedException()
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
