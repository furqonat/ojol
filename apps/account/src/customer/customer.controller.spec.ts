import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'
import { UnauthorizedException } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { Test, TestingModule } from '@nestjs/testing'
import { CustomerController } from './customer.controller'
import { CustomerService } from './customer.service'

describe('CustomerController', () => {
  let controller: CustomerController
  let getCustomerMock: jest.Mock
  let basicUpdateMock: jest.Mock

  beforeEach(async () => {
    getCustomerMock = jest.fn()
    basicUpdateMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CustomerController],
      providers: [
        PrismaService,
        FirebaseService,
        ConfigService,
        {
          provide: CustomerService,
          useValue: {
            getCustomer: getCustomerMock,
            basicUpdate: basicUpdateMock,
          },
        },
      ],
    }).compile()

    controller = module.get<CustomerController>(CustomerController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })

  describe('get customer without parameters', () => {
    const customer = {
      id: '12345',
    }
    beforeEach(() => {
      getCustomerMock.mockReturnValue(customer)
    })

    it('test get custumer without parameters', async () => {
      const result = await controller.getCustomer({ uid: '12345' })
      expect(result.id).toBe(customer.id)
      expect(result.name).toBe(undefined)
    })
  })
  describe('get customer with parameters', () => {
    const customer = {
      id: '12345',
      name: 'test user',
    }
    beforeEach(() => {
      getCustomerMock.mockReturnValue(customer)
    })

    it('test get custumer with parameters', async () => {
      const result = await controller.getCustomer(
        { uid: '12345' },
        {
          name: true,
          id: true,
        },
      )
      expect(result.id).toBe(customer.id)
      expect(result.name).toBe(customer.name)
    })
  })

  describe('get customer and return Unauthorization', () => {
    it('test get custumer with parameters', async () => {
      try {
        await controller.getCustomer()
      } catch (e) {
        expect(e).toBeInstanceOf(UnauthorizedException)
      }
    })
  })

  describe('update basic customer and return OK', () => {
    const response = {
      message: 'OK',
      res: '12345',
    }

    beforeEach(() => {
      basicUpdateMock.mockReturnValue(response)
    })

    it('test update basic return OK', async () => {
      const result = await controller.basicUpdateCustomer(
        { name: '1234', avatar: 'https://sample.com' },
        { uid: '12345' },
      )
      expect(result.message).toBe(response.message)
      expect(result.res).toBe(response.res)
    })
  })

  describe('update basic customer and return UnAuthorized', () => {
    it('test update basic and return UnAuthorized', async () => {
      try {
        await controller.basicUpdateCustomer({
          name: 'adasd',
          avatar: 'https://sample.com',
        })
      } catch (e) {
        expect(e).toBeInstanceOf(UnauthorizedException)
      }
    })
  })
})
