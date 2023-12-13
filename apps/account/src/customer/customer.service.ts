import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common'
import { Prisma, PrismaService } from '@lugo/prisma'
import { FirebaseService } from '@lugo/firebase'
import { CustomerBasicUpdate } from '../dto/customer.dto'

@Injectable()
export class CustomerService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly firebase: FirebaseService,
  ) {}

  async getCustomer(customerId: string, select?: Prisma.customerSelect) {
    try {
      const customer = await this.prismaService.customer.findUnique({
        where: {
          id: customerId,
        },
        select: select ? select : { id: true },
      })
      return customer
    } catch (e) {
      throw new NotFoundException({ message: 'User not found', error: e })
    }
  }

  async basicUpdate(customerId: string, data: CustomerBasicUpdate) {
    try {
      const customer = await this.getCustomer(customerId, {
        id: true,
        name: true,
        avatar: true,
        email: true,
        phone: true,
      })
      await this.prismaService.customer.update({
        where: {
          id: customerId,
        },
        data: {
          name: data.name ?? customer.name,
          avatar: data.avatar ?? customer.avatar,
          email: data.email ?? customer.email,
          phone: data.phoneNumber ?? customer.phone,
        },
      })
      await this.firebase.auth.updateUser(customerId, {
        displayName: data?.name ?? customer.name,
        photoURL: data?.avatar ?? customer.avatar,
        phoneNumber: data?.phoneNumber ?? customer.phone,
        email: data?.email ?? customer.email,
      })
      return {
        message: 'OK',
        res: customerId,
      }
    } catch (e) {
      throw new InternalServerErrorException()
    }
  }

  //   async emailUpdate(token: string, email: string) {
  //     const decodeToken = await this.firebase.auth.verifyIdToken(token)
  //   }
}
