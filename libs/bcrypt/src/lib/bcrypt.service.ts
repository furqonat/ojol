import { Injectable } from '@nestjs/common'
import * as bcrypt from 'bcrypt'

@Injectable()
export class BcryptService {
  async comparePassword(plainPsw: string, hashPsw: string) {
    return await bcrypt.compare(plainPsw, hashPsw)
  }

  async generateHashPassword(plainPsw: string) {
    return bcrypt.hash(plainPsw, 10)
  }
}
