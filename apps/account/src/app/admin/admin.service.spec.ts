import { Test, TestingModule } from '@nestjs/testing'
import { AdminService } from './admin.service'
import { UsersPrismaService } from '@lugo/users'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'
import { BcryptService } from '@lugo/bcrypt'

describe('AdminService', () => {
  let service: AdminService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AdminService,
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
