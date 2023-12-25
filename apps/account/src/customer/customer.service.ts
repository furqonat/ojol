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

  async saveDeviceToken(customerId: string, token: string) {
    const deviceTokenExist =
      await this.prismaService.customer_device_token.findUnique({
        where: {
          customer_id: customerId,
        },
      })
    if (deviceTokenExist) {
      const deviceToken = await this.prismaService.customer_device_token.update(
        {
          where: {
            customer_id: customerId,
          },
          data: {
            token: token,
          },
        },
      )
      return {
        message: 'OK',
        res: deviceToken.id,
      }
    }
    const deviceToken = await this.prismaService.customer_device_token.create({
      data: {
        token: token,
        customer_id: customerId,
      },
    })
    return {
      message: 'OK',
      res: deviceToken.id,
    }
  }
}
