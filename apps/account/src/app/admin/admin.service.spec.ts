import { Test, TestingModule } from '@nestjs/testing'
import { AdminService } from './admin.service'
import { UsersPrismaService } from '@lugo/users'

describe('AdminService', () => {
  let service: AdminService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AdminService, UsersPrismaService],
    }).compile()

    service = module.get<AdminService>(AdminService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
