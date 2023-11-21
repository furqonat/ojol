import { Test, TestingModule } from '@nestjs/testing'
import { AdminService } from './admin.service'
import { BcryptService } from '@lugo/bcrypt'
import { JwtService } from '@nestjs/jwt'
import { admin } from '@prisma/client/auth'
import { UsersPrismaService } from '@lugo/users'

describe('AdminService', () => {
  let service: AdminService
  let comparePasswordMock: jest.Mock
  let findUniqueMock: jest.Mock
  let signAsyncMock: jest.Mock
  beforeEach(async () => {
    comparePasswordMock = jest.fn()
    findUniqueMock = jest.fn()
    signAsyncMock = jest.fn()

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AdminService,
        {
          provide: BcryptService,
          useValue: {
            comparePassword: comparePasswordMock,
          },
        },
        {
          provide: UsersPrismaService,
          useValue: {
            admin: {
              findUnique: findUniqueMock,
            },
          },
        },
        {
          provide: JwtService,
          useValue: {
            signAsync: signAsyncMock,
          },
        },
      ],
    }).compile()

    service = module.get<AdminService>(AdminService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })

  describe('should be return token when signIn', () => {
    let adminT: admin
    const token = '1231234'
    beforeEach(() => {
      adminT = {
        id: '123',
        name: 'admintest',
        email: 'admintest@mail.com',
        password: '12341234',
        last_sign_in: undefined,
        status: false,
      }
      findUniqueMock.mockReturnValue(adminT)
      comparePasswordMock.mockReturnValue(true)
      signAsyncMock.mockReturnValue(token)
    })
    it('test signin with valid credential', async () => {
      const result = await service.signIn('admintest@mail.com', '12341234')
      expect(result.token).toBe(token)
    })
  })

  describe('should be null return token when signIn', () => {
    beforeEach(() => {
      findUniqueMock.mockReturnValue(undefined)
      comparePasswordMock.mockReturnValue(false)
    })

    it('test signin with invalid email', async () => {
      const result = await service.signIn('admintest', '1234')
      expect(result.token).toBe(null)
    })
  })

  describe('should be null return token when signIn', () => {
    let adminT: admin
    beforeEach(() => {
      adminT = {
        id: '123',
        name: 'admintest',
        email: 'admintest@mail.com',
        password: '12341234',
        last_sign_in: undefined,
        status: false,
      }
      findUniqueMock.mockReturnValue(adminT)
      comparePasswordMock.mockReturnValue(false)
    })
    it('test signin with valid email but invalid password', async () => {
      const result = await service.signIn('admintest@mail.com', '12341234')
      expect(result.token).toBe(null)
    })
  })
})
