import { Test, TestingModule } from '@nestjs/testing'
import { AdminController } from './admin.controller'
import { AdminService } from './admin.service'
import { BadRequestException } from '@nestjs/common'

describe('AdminController', () => {
  let controller: AdminController
  let signInMock: jest.Mock

  beforeEach(async () => {
    signInMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AdminController],
      providers: [
        {
          provide: AdminService,
          useValue: {
            signIn: signInMock,
          },
        },
      ],
    }).compile()

    controller = module.get<AdminController>(AdminController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })

  describe('return admin if credential is valid', () => {
    beforeEach(() => {
      signInMock.mockReturnValue({
        id: '1234',
        name: 'test',
      })
    })
    it('test signin and return admin', async () => {
      const result = await controller.signIn({
        email: 'email',
        password: 'password',
      })
      expect(result.name).toBe('test')
    })
  })
  describe('return message is invalid credential if credential is invalid', () => {
    beforeEach(() => {
      signInMock.mockReturnValue(undefined)
    })
    it('test signin and invalid credential', async () => {
      try {
        await controller.signIn({
          email: 'email',
          password: 'password',
        })
      } catch (e) {
        expect(e).toBeInstanceOf(BadRequestException)
      }
    })
  })
  describe('return message is bad request when some field not provided', () => {
    it('test signin and invalid credential', async () => {
      try {
        await controller.signIn({
          email: '',
          password: 'password',
        })
      } catch (e) {
        expect(e).toBeInstanceOf(BadRequestException)
      }
    })
  })
})
