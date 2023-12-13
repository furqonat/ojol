import { Prisma } from '@prisma/client/users'

export type CustomerBasicUpdate = {
  name?: string
  avatar?: string
  email?: string
  phoneNumber?: string
}

export interface CustomerQuery
  extends Omit<
    Prisma.customerSelect,
    '_count' | 'password' | 'last_sign_in' | 'email_verified' | 'phone_verified'
  > {}
