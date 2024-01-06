import axios from 'axios'
import { initializeApp } from 'firebase/app'
import {
  UserCredential,
  getAuth,
  getIdToken,
  signInWithEmailAndPassword,
} from 'firebase/auth'
const firebaseConfig = {
  apiKey: 'AIzaSyD48SQUoAlU32Ryi_dm1Wr3GjnhYtGk150',
  authDomain: 'lumajanglugo.firebaseapp.com',
  projectId: 'lumajanglugo',
  storageBucket: 'lumajanglugo.appspot.com',
  messagingSenderId: '319389880269',
  appId: '1:319389880269:web:35bc6743ee7593101dfe84',
  measurementId: 'G-DXV71QRQYF',
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
    })
  })
})
