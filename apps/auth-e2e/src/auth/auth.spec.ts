import axios from 'axios'
import { initializeApp } from 'firebase/app'
import {
  UserCredential,
  getAuth,
  getIdToken,
  signInWithEmailAndPassword,
} from 'firebase/auth'

const firebaseConfig = {
  apiKey: process.env.API_KEY,
  authDomain: process.env.AUTH_DOMAIN,
  projectId: process.env.PROJECT_ID,
  storageBucket: process.env.STORAGE_BUCKET,
  messagingSenderId: process.env.MESSAGING_SENDER_ID,
  appId: process.env.APP_ID,
  measurementId: process.env.MEASUREMENT_ID,
}

describe('Test Autentication Api', () => {
  let customerCred: UserCredential
  let driverCred: UserCredential
  let merchantCred: UserCredential

  beforeAll(async () => {
    const app = initializeApp(firebaseConfig)
    const emailCustomer = 'test@example.com'
    const passwordCustomer = 'password123'
    const emailDriver = 'testdriver@example.com'
    const passwordDriver = 'password123'
    const emailMerch = 'testmerch@example.com'
    const passwordMerch = 'password1234'

    const auth = getAuth(app)

    const userCredential = await signInWithEmailAndPassword(
      auth,
      emailCustomer,
      passwordCustomer,
    )
    const driverCredential = await signInWithEmailAndPassword(
      auth,
      emailDriver,
      passwordDriver,
    )
    const merchantCredential = await signInWithEmailAndPassword(
      auth,
      emailMerch,
      passwordMerch,
    )
    customerCred = userCredential
    driverCred = driverCredential
    merchantCred = merchantCredential
  })

  describe('POST /customer/signIn', () => {
    it('should return a token and message OK', async () => {
      const userToken = await getIdToken(customerCred.user)
      const res = await axios.post(
        `/dev/customer`,
        {},
        {
          headers: {
            Authorization: `Bearer ${userToken}`,
          },
        },
      )

      expect(res.status).toBe(201)
      expect(res.data.message).toBe('OK')
    })
  })

  describe('POST /driver/signIn', () => {
    it('should return a token and message OK', async () => {
      const userToken = await getIdToken(driverCred.user)
      const res = await axios.post(
        `/dev/driver`,
        {},
        {
          headers: {
            Authorization: `Bearer ${userToken}`,
          },
        },
      )

      expect(res.status).toBe(201)
      expect(res.data.message).toBe('OK')
    })
  })

  describe('POST /merchant/signIn', () => {
    it('should return a token and message OK', async () => {
      const userToken = await getIdToken(merchantCred.user)
      const res = await axios.post(
        `/dev/merchant`,
        {},
        {
          headers: {
            Authorization: `Bearer ${userToken}`,
          },
        },
      )

      expect(res.status).toBe(201)
      expect(res.data.message).toBe('OK')
    })
  })
})
