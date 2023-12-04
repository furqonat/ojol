import { Test, TestingModule } from '@nestjs/testing'
import { AdminService } from './admin.service'
import { UsersPrismaService } from '@lugo/users'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'
import { BcryptService } from '@lugo/bcrypt'
import { JwtService } from '@nestjs/jwt'
import { RolesGuard } from '@lugo/jwtguard'

describe('AdminService', () => {
  let service: AdminService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        JwtService,
        AdminService,
        RolesGuard,
        UsersPrismaService,
        FirebaseService,
        ConfigService,
        BcryptService,
      ],
    }).compile()

    service = module.get<AdminService>(AdminService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
