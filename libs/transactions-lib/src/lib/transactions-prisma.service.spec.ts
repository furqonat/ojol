import { Test, TestingModule } from '@nestjs/testing'
import { TransactionsPrismaService } from './transactions.service'

describe('UsersPrismaService', () => {
  let service: TransactionsPrismaService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [TransactionsPrismaService],
    }).compile()

    service = module.get<TransactionsPrismaService>(TransactionsPrismaService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
