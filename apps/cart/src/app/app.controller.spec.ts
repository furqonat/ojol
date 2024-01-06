import { Test } from '@nestjs/testing'

import { AppController } from './app.controller'
import { AppService } from './app.service'

describe('AppController', () => {
  let controller: AppController

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      controllers: [AppController],
      providers: [AppService],
    }).compile()
    controller = module.get<AppController>(AppController)
  })

  describe('getData', () => {
    controller.getCarts('adasda', {})
    // it('should return "Hello API"', () => {
    //   const appController = app.get<AppController>(AppController)
    //   expect(appController.getData()).toEqual({ message: 'Hello API' })
    // })
  })
})
