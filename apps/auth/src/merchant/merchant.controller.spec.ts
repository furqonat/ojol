import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'
import { Test, TestingModule } from '@nestjs/testing'
import { MerchantController } from './merchant.controller'
import { MerchantService } from './merchant.service'
import { UnauthorizedException } from '@nestjs/common'
import { PrismaService } from '@lugo/prisma'

describe('MerchantController', () => {
  let controller: MerchantController
  let signInMock: jest.Mock

  beforeEach(async () => {
    signInMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MerchantController],
      providers: [
        FirebaseService,
        ConfigService,
        PrismaService,
        {
          provide: MerchantService,
          useValue: {
            signIn: signInMock,
          },
        },
      ],
    }).compile()

    controller = module.get<MerchantController>(MerchantController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })

  describe('should be return token if token is avaliable', () => {
    let response: { message: string; token: string }
    beforeEach(() => {
      response = {
        message: 'OK',
        token: '1234134',
      }
      signInMock.mockReturnValue(response)
    })
    it('test user signin with header token provided', async () => {
      const result = await controller.signIn('12312312')
      expect(result.token).toBe(response.token)
    })

    it('test user signin without header token provided', async () => {
      try {
        await controller.signIn()
      } catch (error) {
        expect(error).toBeInstanceOf(UnauthorizedException)
      }
    })
  })
})
