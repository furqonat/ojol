import { GuardModule } from '@lugo/guard'
import { PrismaModule } from '@lugo/prisma'
import { Test, TestingModule } from '@nestjs/testing'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { FirebaseModule } from '@lugo/firebase'

describe('MerchantController', () => {
  let controller: MerchantController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [GuardModule, PrismaModule, FirebaseModule],
      controllers: [MerchantController],
      providers: [MerchantService],
    }).compile()

    controller = module.get<MerchantController>(MerchantController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
