import {
  HttpStatus,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common'
import { Prisma, PrismaService } from '@lugo/prisma'
import { FirebaseService } from '@lugo/firebase'
import { CustomerBasicUpdate } from '../dto/customer.dto'
import { otpGenerator, sendSms } from '@lugo/common'

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

  async obtainVerificationCode(phone: string) {
    const code = otpGenerator()
    const message = `Y0ur V3R1f1c4t10n C0d3 Is ${code}.`
    const verifcationId = await this.prismaService.verification.create({
      data: {
        phone: phone,
        code: code,
      },
    })
    const resp = await sendSms(phone, message)
    if (resp == HttpStatus.CREATED) {
      return {
        message: 'OK',
        res: verifcationId.id,
      }
    } else {
      await this.prismaService.verification.delete({
        where: {
          id: verifcationId.id,
        },
      })
      throw new InternalServerErrorException({
        message: 'Internal Server Error',
        error: resp,
      })
    }
  }

  async phoneVerification(
    customerId: string,
    verifcationId: string,
    smsCode: number,
  ) {
    const verification = await this.prismaService.verification.findUnique({
      where: {
        id: verifcationId,
      },
    })
    if (verification.code == smsCode) {
      await this.prismaService.customer.update({
        where: {
          id: customerId,
        },
        data: {
          phone_verified: true,
          phone: verification.phone,
        },
      })
      return {
        message: 'OK',
        res: customerId,
      }
    }
    throw new UnauthorizedException({
      message: 'Invalid verification code',
    })
  }
}
