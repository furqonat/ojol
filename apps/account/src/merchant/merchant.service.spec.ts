import { Test, TestingModule } from '@nestjs/testing'
import { MerchantService } from './merchant.service'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'
import { ConfigService } from '@nestjs/config'

describe('MerchantService', () => {
  let service: MerchantService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MerchantService,
        FirebaseService,
        PrismaService,
        ConfigService,
      ],
    }).compile()

    service = module.get<MerchantService>(MerchantService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
