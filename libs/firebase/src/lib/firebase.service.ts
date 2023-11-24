import { Inject, Injectable } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import * as admin from 'firebase-admin'
import { App, getApps } from 'firebase-admin/app'
import { Auth, getAuth } from 'firebase-admin/auth'
import { Firestore, getFirestore } from 'firebase-admin/firestore'

@Injectable()
export class FirebaseService {
  public readonly app!: App
  public readonly auth: Auth
  public readonly firestore: Firestore

  constructor(@Inject(ConfigService) private readonly config: ConfigService) {
    if (!this.app && getApps().length === 0) {
      this.app = admin.initializeApp()
    } else {
      this.app = getApps()[0]
    }
    this.firestore = getFirestore(this.app)
    this.auth = getAuth(this.app)
  }
}
