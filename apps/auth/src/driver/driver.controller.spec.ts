import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'
import { Test, TestingModule } from '@nestjs/testing'
import { DriverController } from './driver.controller'
import { DriverService } from './driver.service'
import { UnauthorizedException } from '@nestjs/common'
import { PrismaService } from '@lugo/prisma'

describe('DriverController', () => {
  let controller: DriverController
  let signInMock: jest.Mock

  beforeEach(async () => {
    signInMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      controllers: [DriverController],
      providers: [
        FirebaseService,
        ConfigService,
        PrismaService,
        {
          provide: DriverService,
          useValue: {
            signIn: signInMock,
          },
        },
      ],
    }).compile()

    controller = module.get<DriverController>(DriverController)
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
