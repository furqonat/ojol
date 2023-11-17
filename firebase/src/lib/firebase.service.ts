import { Inject, Injectable } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { App, getApps } from 'firebase-admin/app'
import { Auth, getAuth } from 'firebase-admin/auth'
import * as admin from 'firebase-admin'

@Injectable()
export class FirebaseService {
  public readonly app!: App
  public readonly auth: Auth

  constructor(@Inject(ConfigService) private readonly config: ConfigService) {
    if (!this.app && getApps().length === 0) {
      this.app = admin.initializeApp()
    } else {
      this.app = getApps()[0]
    }

    this.auth = getAuth(this.app)
  }
}
