import {
  customerSignIn,
  driverSignIn,
  getFirebaseConfig,
} from '@lugo/firebase-e2e'
import axios, { HttpStatusCode } from 'axios'
import { initializeApp } from 'firebase/app'
import { UserCredential, getAuth, getIdToken } from 'firebase/auth'

describe('Test Autentication Api', () => {
  let cusCred: UserCredential
  let driCred: UserCredential
  beforeAll(async () => {
    const app = initializeApp(getFirebaseConfig())
    const auth = getAuth(app)
    const resCus = await customerSignIn(
      auth,
      process.env.EMAILCUSTOMER,
      process.env.PASSWORDCUSTOMER,
    )
    cusCred = resCus

    const resDri = await driverSignIn(
      auth,
      process.env.EMAILDRIVER,
      process.env.PASSWORDDRIVER,
    )
    driCred = resDri
  })

  describe('POST /order/ create new order', () => {
    it('Test Create Order from user', async () => {
      const token = await getIdToken(cusCred.user)
      const resp = await axios.post(
        '/order/',
        {
          order_type: 'FOOD',
          payment_type: 'DANA',
          gross_amount: 100000,
          net_amount: 100000,
          total_amount: 150000,
          shipping_cost: 50000,
          product: [
            {
              quantity: 1,
              product_id: 'clq7m09gj0001dev6y4kcvpvp',
            },
          ],
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Created)
    })
  })
  describe('GET /order/ getvaliable order', () => {
    it('Test Create Order from user', async () => {
      const token = await getIdToken(driCred.user)
      const resp = await axios.get('/order/', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      console.info(JSON.stringify(resp.data, undefined, 2))
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('PUT /order/ driver sign on order', () => {
    it('Test assign driver id on order', async () => {
      const token = await getIdToken(driCred.user)
      const resp = await axios.put(
        '/order/driver/sign/clqje77u90000dmkc57v4ytmj',
        {},
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('PUT /order/driver/:orderId user or mechant find driver', () => {
    it('Test Find Driver', async () => {
      const token = await getIdToken(cusCred.user)
      const resp = await axios.put(
        '/order/driver/clqje77u90000dmkc57v4ytmj',
        {
          latitude: -6.334857,
          longitude: 106.475847,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })

  describe('PUT /order/driver/reject/:orderId driver reject order', () => {
    it('Test Driver Reject Order', async () => {
      const token = await getIdToken(driCred.user)
      const resp = await axios.put(
        '/order/driver/reject/clqje77u90000dmkc57v4ytmj',
        {},
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('PUT /order/driver/accept/:orderId driver reject order', () => {
    it('Test Driver Accept Order', async () => {
      const token = await getIdToken(driCred.user)
      const resp = await axios.put(
        '/order/driver/accept/clqje77u90000dmkc57v4ytmj',
        {},
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
})
