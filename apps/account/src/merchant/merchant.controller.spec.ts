import { Test, TestingModule } from '@nestjs/testing'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { UsersPrismaService } from '@lugo/users'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'

describe('MerchantController', () => {
  let controller: MerchantController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MerchantController],
      providers: [
        MerchantService,
        UsersPrismaService,
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
