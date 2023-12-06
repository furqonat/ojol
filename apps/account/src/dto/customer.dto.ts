import { Prisma } from '@prisma/client/users'

export type CustomerBasicUpdate = {
  name?: string
  avatar?: string
}

export interface CustomerQuery extends Omit<Prisma.customerSelect, '_count'> {}
