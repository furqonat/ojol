import { Test, TestingModule } from '@nestjs/testing'
import { MerchantService } from './merchant.service'
import { FirebaseService } from '@lugo/firebase'
import { UsersPrismaService } from '@lugo/users'
import { ConfigService } from '@nestjs/config'

describe('MerchantService', () => {
  let service: MerchantService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MerchantService,
        FirebaseService,
        UsersPrismaService,
        ConfigService,
      ],
    }).compile()

    service = module.get<MerchantService>(MerchantService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
