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

  async getCustomer(token: string, select?: Prisma.customerSelect) {
    try {
      const decodeToken = await this.firebase.auth.verifyIdToken(token)
      const customer = await this.prismaService.customer.findUnique({
        where: {
          id: decodeToken.uid,
        },
        select: select ? select : { id: true },
      })
      return customer
    } catch (e) {
      throw new NotFoundException({ message: 'User not found', error: e })
    }
  }

  async basicUpdate(token: string, data: CustomerBasicUpdate) {
    try {
      const decodeToken = await this.firebase.auth.verifyIdToken(token)
      const customer = await this.getCustomer(token, {
        id: true,
        name: true,
        avatar: true,
        email: true,
        phone: true,
      })
      await this.prismaService.customer.update({
        where: {
          id: decodeToken.uid,
        },
        data: {
          name: data.name ?? customer.name,
          avatar: data.avatar ?? customer.avatar,
          email: data.email ?? customer.email,
          phone: data.phoneNumber ?? customer.phone,
        },
      })
      await this.firebase.auth.updateUser(decodeToken.uid, {
        displayName: data?.name ?? customer.name,
        photoURL: data?.avatar ?? customer.avatar,
        phoneNumber: data?.phoneNumber ?? customer.phone,
        email: data?.email ?? customer.email,
      })
      return {
        message: 'OK',
        res: decodeToken.uid,
      }
    } catch (e) {
      throw new InternalServerErrorException()
    }
  }

  //   async emailUpdate(token: string, email: string) {
  //     const decodeToken = await this.firebase.auth.verifyIdToken(token)
  //   }
}
