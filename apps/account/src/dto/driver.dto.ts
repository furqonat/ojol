import { Prisma } from '@prisma/client/users'

export interface ApplyDriver {
  details: Prisma.driver_detailsCreateInput
  referal: string
  name: string
}
