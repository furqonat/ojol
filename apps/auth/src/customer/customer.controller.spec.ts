import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'
import { Test, TestingModule } from '@nestjs/testing'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'
import { UnauthorizedException } from '@nestjs/common'
import { PrismaService } from '@lugo/prisma'

describe('CustomerController', () => {
  let controller: CustomerController
  let signInMock: jest.Mock

  beforeEach(async () => {
    signInMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CustomerController],
      providers: [
        FirebaseService,
        ConfigService,
        PrismaService,
        {
          provide: CustomerService,
          useValue: {
            signIn: signInMock,
          },
        },
      ],
    }).compile()

    controller = module.get<CustomerController>(CustomerController)
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
