import { Test, TestingModule } from '@nestjs/testing'
import { CustomerService } from './customer.service'
import { FirebaseService } from '@lugo/firebase'
import { PrismaService } from '@lugo/prisma'
import { InternalServerErrorException, NotFoundException } from '@nestjs/common'
import { UserRecord } from 'firebase-admin/auth'

describe('CustomerService', () => {
  let service: CustomerService
  let verifyIdTokenMock: jest.Mock
  let updateUserMock: jest.Mock
  let findUniqueMock: jest.Mock
  let updateMock: jest.Mock

  beforeEach(async () => {
    verifyIdTokenMock = jest.fn()
    updateMock = jest.fn()
    updateUserMock = jest.fn()
    findUniqueMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CustomerService,
        {
          provide: FirebaseService,
          useValue: {
            auth: {
              verifyIdToken: verifyIdTokenMock,
              updateUser: updateUserMock,
            },
          },
        },
        {
          provide: PrismaService,
          useValue: {
            customer: {
              findUnique: findUniqueMock,
              update: updateMock,
            },
          },
        },
      ],
    }).compile()

    service = module.get<CustomerService>(CustomerService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })

  describe('get customer without select', () => {
    const decodeToken = { uid: '12345' }
    const token = '123412345131a'
    const customer = {
      id: '12345',
    }

    beforeEach(() => {
      verifyIdTokenMock.mockReturnValue(decodeToken)
      findUniqueMock.mockReturnValue(customer)
    })

    it('test get user with token and without select', async () => {
      const result = await service.getCustomer(token)
      expect(result.id).toBe(customer.id)
    })
  })

  describe('get customer with select prompt', () => {
    const decodeToken = { uid: '12345' }
    const token = '1wefaffaas'
    const customer = {
      id: '12345',
      name: 'test user',
    }
    beforeEach(() => {
      verifyIdTokenMock.mockReturnValue(decodeToken)
      findUniqueMock.mockReturnValue(customer)
    })

    it('test get user with token and select', async () => {
      const result = await service.getCustomer(token, { id: true, name: true })
      expect(result.name).toBe(customer.name)
    })
  })

  describe('get customer and return not found', () => {
    beforeEach(() => {
      verifyIdTokenMock.mockReturnValue(undefined)
      findUniqueMock.mockReturnValue(undefined)
    })
    it('get user but return not found', async () => {
      try {
        await service.getCustomer('12345')
      } catch (e) {
        expect(e).toBeInstanceOf(NotFoundException)
      }
    })
  })

  describe('basic update users and return OK', () => {
    const decodeToken = { uid: '12345' }
    const token = '12345'
    const customer = {
      id: '12345',
      name: 'test user',
      avatar: 'https://example.com/',
    }
    const updateCustomer = {
      id: '12345',
      name: 'user 1234',
      avatar: 'https://sample.com',
    }
    const updateUser: Partial<UserRecord> = {
      displayName: 'user 1234',
      photoURL: 'https://sample.com',
    }
    beforeEach(() => {
      verifyIdTokenMock.mockReturnValue(decodeToken)
      findUniqueMock.mockReturnValue(customer)
      updateMock.mockReturnValue(updateCustomer)
      updateUserMock.mockReturnValue(updateUser)
    })

    it('test update basic user and return OK', async () => {
      const result = await service.basicUpdate(token, {
        name: 'user 1234',
        avatar: 'https://sample.com',
      })
      expect(result.message).toBe('OK')
    })
  })

  describe('basic update user and return 5xx', () => {
    beforeEach(() => {
      verifyIdTokenMock.mockReturnValue(undefined)
    })

    it('test basic update and return 5xx', async () => {
      try {
        await service.basicUpdate('12345', {
          name: 'test',
          avatar: 'https://sample.com',
        })
      } catch (e) {
        expect(e).toBeInstanceOf(InternalServerErrorException)
      }
    })
  })
})
