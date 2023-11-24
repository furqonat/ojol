import { BcryptService } from '@lugo/bcrypt'
import { UsersPrismaService } from '@lugo/users'
import { Test, TestingModule } from '@nestjs/testing'
import { admin } from '@prisma/client/users'
import { AdminService } from './admin.service'
import { BadRequestException } from '@nestjs/common'

describe('AdminService', () => {
  let service: AdminService
  let comparePasswordMock: jest.Mock
  let findUniqueMock: jest.Mock
  beforeEach(async () => {
    comparePasswordMock = jest.fn()
    findUniqueMock = jest.fn()

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
      ],
    }).compile()

    service = module.get<AdminService>(AdminService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })

  describe('should be return token when signIn', () => {
    let adminT: admin
    beforeEach(() => {
      adminT = {
        id: '123',
        name: 'admintest',
        email: 'admintest@mail.com',
        password: '12341234',
        last_sign_in: undefined,
        status: false,
        avatar: '',
      }
      findUniqueMock.mockReturnValue(adminT)
      comparePasswordMock.mockReturnValue(true)
    })
    it('test signin with valid credential', async () => {
      const result = await service.signIn('admintest@mail.com', '12341234')
      expect(result.id).toBe(adminT.id)
    })
  })

  describe('should be null return token when signIn', () => {
    beforeEach(() => {
      findUniqueMock.mockReturnValue(undefined)
      comparePasswordMock.mockReturnValue(false)
    })

    it('test signin with invalid email', async () => {
      try {
        await service.signIn('admintest', '1234')
      } catch (e) {
        expect(e).toBeInstanceOf(BadRequestException)
      }
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
        avatar: '',
      }
      findUniqueMock.mockReturnValue(adminT)
      comparePasswordMock.mockReturnValue(false)
    })
    it('test signin with valid email but invalid password', async () => {
      try {
        await service.signIn('admintest@mail.com', '12341234')
      } catch (e) {
        expect(e).toBeInstanceOf(BadRequestException)
      }
    })
  })
})
