import axios from 'axios'
import { initializeApp } from 'firebase/app'
import {
  UserCredential,
  getAuth,
  getIdToken,
  signInWithEmailAndPassword,
} from 'firebase/auth'
import { getFirebaseConfig } from '@lugo/firebase-e2e'

describe('Test Autentication Api', () => {
  let customerCred: UserCredential
  let driverCred: UserCredential
  let merchantCred: UserCredential

  beforeAll(async () => {
    const app = initializeApp(getFirebaseConfig())

    const auth = getAuth(app)

    const userCredential = await signInWithEmailAndPassword(
      auth,
      process.env.EMAILCUSTOMER,
      process.env.PASSWORDCUSTOMER,
    )
    const driverCredential = await signInWithEmailAndPassword(
      auth,
      process.env.EMAILDRIVER,
      process.env.PASSWORDDRIVER,
    )
    const merchantCredential = await signInWithEmailAndPassword(
      auth,
      process.env.TEST_EMAIL_MERCH,
      process.env.TEST_PSW_MERCH,
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
