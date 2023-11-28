import { Test, TestingModule } from '@nestjs/testing'
import { MartController } from './mart.controller'

describe('MartController', () => {
  let controller: MartController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MartController],
    }).compile()

    controller = module.get<MartController>(MartController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
