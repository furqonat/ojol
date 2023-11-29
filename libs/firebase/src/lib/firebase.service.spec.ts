import { Test, TestingModule } from '@nestjs/testing'
import { FirebaseService } from './firebase.service'
import { ConfigService } from '@nestjs/config'

describe('FirebaseService', () => {
  let service: FirebaseService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [FirebaseService, ConfigService],
    }).compile()

    service = module.get<FirebaseService>(FirebaseService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
