import { PrismaService } from '@lugo/prisma'
import { BadRequestException, NotFoundException } from '@nestjs/common'
import { Test, TestingModule } from '@nestjs/testing'
import { DriverService } from './driver.service'

describe('DriverService', () => {
  let service: DriverService
  let findUniqueMock: jest.Mock
  let findUniqueMockDetails: jest.Mock
  let updateMock: jest.Mock

  beforeEach(async () => {
    findUniqueMock = jest.fn()
    findUniqueMockDetails = jest.fn()
    updateMock = jest.fn()
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        DriverService,
        {
          provide: PrismaService,
          useValue: {
            driver: {
              findUnique: findUniqueMock,
              update: updateMock,
            },
            driver_details: {
              findUnique: findUniqueMockDetails,
            },
          },
        },
      ],
    }).compile()

    service = module.get<DriverService>(DriverService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })

  describe('get driver without select', () => {
    const token = '123456789'
    const driver = {
      id: '123456789',
    }
    beforeEach(() => {
      findUniqueMock.mockReturnValue(driver)
    })

    it('test get driver without select', async () => {
      const result = await service.getDriver(token)
      expect(result.id).toBe(driver.id)
    })
  })

  describe('get driver with select', () => {
    const token = '123456789'
    const driver = {
      id: '123456789',
      name: 'ahmad',
    }
    beforeEach(() => {
      findUniqueMock.mockReturnValue(driver)
    })

    it('test get driver with select', async () => {
      const result = await service.getDriver(token, { name: true, id: true })
      expect(result.id).toBe(driver.id)
      expect(result.name).toBe(driver.name)
    })
  })

  describe('get driver and return not found exception', () => {
    beforeEach(() => {
      findUniqueMock.mockReturnValue(undefined)
    })

    it('test get driver and return not found exception', async () => {
      try {
        await service.getDriver('12345')
      } catch (e) {
        expect(e).toBeInstanceOf(NotFoundException)
      }
    })
  })

  describe('apply driver and return ok', () => {
    const update = {
      id: '123456',
      driver_details: {
        id: '321',
      },
    }
    beforeEach(() => {
      updateMock.mockReturnValue(update)
      findUniqueMockDetails.mockReturnValue(undefined)
    })

    it('test apply driver and return ok', async () => {
      const result = await service.applyDriver('12345', {
        details: {
          address: 'test address',
          license_image: 'https://test.com',
          id_card_image: 'https://test.com',
        },
      })
      expect(result.message).toBe('OK')
      expect(result.res).toBe(update.driver_details.id)
    })
  })

  describe('apply driver and return bad request', () => {
    const driver_details = {
      id: '12345543',
    }
    beforeEach(() => {
      findUniqueMockDetails.mockReturnValue(driver_details)
    })

    it('test apply and return bad request', async () => {
      try {
        await service.applyDriver('1234567', {
          details: {
            address: '',
            license_image: '',
            id_card_image: '',
          },
        })
      } catch (e) {
        expect(e).toBeInstanceOf(BadRequestException)
      }
    })
  })

  describe('apply driver and return driver not found', () => {
    it('test driver and return driver not found', async () => {
      try {
        await service.applyDriver('123456', {
          details: {
            address: '',
            license_image: '',
            id_card_image: '',
          },
        })
      } catch (e) {
        expect(e).toBeInstanceOf(BadRequestException)
      }
    })
  })
})
