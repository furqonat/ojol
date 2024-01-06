import { Prisma } from '@prisma/client/users'

export class AdminQueryDTO {
  take?: number

  skip?: number

  query?: string
}

export interface CreateAdminDTO extends Omit<Prisma.adminCreateInput, 'role'> {
  roleId: string
  ref?: string
}
