import { Test, TestingModule } from '@nestjs/testing'
import { CustomerService } from './customer.service'
import { FirebaseService } from '@lugo/firebase'
import { ConfigService } from '@nestjs/config'
import { DecodedIdToken } from 'firebase-admin/auth'
import { customer } from '@prisma/client/auth'
import { UsersPrismaService } from '@lugo/users'

describe('CustomerService', () => {
  let service: CustomerService
  let verifyIdTokenMock: jest.Mock
  let createCustomTokenMock: jest.Mock
  let findUniqueOrThrowMock: jest.Mock
  let createMock: jest.Mock

  beforeEach(async () => {
    verifyIdTokenMock = jest.fn()
    createCustomTokenMock = jest.fn()
    findUniqueOrThrowMock = jest.fn()
    createMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CustomerService,
        {
          provide: FirebaseService,
          useValue: {
            auth: {
              verifyIdToken: verifyIdTokenMock,
              createCustomToken: createCustomTokenMock,
            },
          },
        },
        {
          provide: UsersPrismaService,
          useValue: {
            customer: {
              findUniqueOrThrow: findUniqueOrThrowMock,
              create: createMock,
            },
          },
        },
        ConfigService,
      ],
    }).compile()

    service = module.get<CustomerService>(CustomerService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })

  describe('no need to create user when user claims token', () => {
    let user: DecodedIdToken
    let customers: customer
    let customToken: string
    beforeEach(() => {
      customToken = 'adasajaya'
      customers = {
        id: '123123',
        name: 'Furqon',
        email: 'furqon@ramdhani.com',
        phone: '+6281311131231',
        password: '',
        last_sign_in: undefined,
        last_active: undefined,
        email_verified: false,
        phone_verified: false,
      }
      user = {
        aud: '',
        auth_time: 0,
        exp: 0,
        firebase: {
          identities: {},
          sign_in_provider: '',
          sign_in_second_factor: '',
          second_factor_identifier: '',
          tenant: '',
        },
        iat: 0,
        iss: '',
        sub: '',
        uid: '123123',
        name: 'Furqon',
        phone_number: '+6281311131231',
        email: 'furqon@ramdhani.com',
      }
      verifyIdTokenMock.mockReturnValue(user)
      findUniqueOrThrowMock.mockReturnValue(customers)
      createCustomTokenMock.mockReturnValue(customToken)
    })
    it('user exists in lugo database', async () => {
      const result = await service.signIn('123456')
      expect(result.token).toBe(customToken)
    })
  })

  describe('should be create user when user claims token', () => {
    let user: DecodedIdToken
    let customers: customer
    let customToken: string
    beforeEach(() => {
      customToken = 'pxpxpxpx'
      customers = {
        id: '123123',
        name: 'Furqon',
        email: 'furqon@ramdhani.com',
        phone: '+6281311131231',
        password: '',
        last_sign_in: undefined,
        last_active: undefined,
        email_verified: false,
        phone_verified: false,
      }
      user = {
        aud: '',
        auth_time: 0,
        exp: 0,
        firebase: {
          identities: {},
          sign_in_provider: '',
          sign_in_second_factor: '',
          second_factor_identifier: '',
          tenant: '',
        },
        iat: 0,
        iss: '',
        sub: '',
        uid: '123123',
        name: 'Furqon',
        phone_number: '+6281311131231',
        email: 'furqon@ramdhani.com',
      }
      verifyIdTokenMock.mockReturnValue(user)
      findUniqueOrThrowMock.mockReturnValue(undefined)
      createMock.mockReturnValue(customers)
      createCustomTokenMock.mockReturnValue(customToken)
    })
    it('test create user when user is not exists', async () => {
      const result = await service.signIn('1212123')
      expect(result.token).toBe(`${customToken}`)
    })
  })
})
