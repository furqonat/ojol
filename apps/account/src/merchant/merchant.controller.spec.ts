import { Test, TestingModule } from '@nestjs/testing'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { PrismaService } from '@lugo/prisma'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

describe('MerchantController', () => {
  let controller: MerchantController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MerchantController],
      providers: [
        MerchantService,
        PrismaService,
        FirebaseService,
        ConfigService,
      ],
    }).compile()

    controller = module.get<MerchantController>(MerchantController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
