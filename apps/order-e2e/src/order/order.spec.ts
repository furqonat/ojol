import {
  customerSignIn,
  driverSignIn,
  getFirebaseConfig,
  merchantSignIn,
} from '@lugo/firebase-e2e'
import axios, { HttpStatusCode } from 'axios'
import { initializeApp } from 'firebase/app'
import { UserCredential, getAuth, getIdToken } from 'firebase/auth'

describe('Test Autentication Api', () => {
  let cusCred: UserCredential
  let driCred: UserCredential
  let merCred: UserCredential
  beforeAll(async () => {
    const app = initializeApp(getFirebaseConfig())
    const auth = getAuth(app)
    const resCus = await customerSignIn(
      auth,
      'email@test.com',
      'password123',
    )
    cusCred = resCus

    // const resDri = await driverSignIn(
    //   auth,
    //   process.env.EMAILDRIVER + 1,
    //   process.env.PASSWORDDRIVER + 1,
    // )
    // driCred = resDri

    // const resMerch = await merchantSignIn(
    //   auth,
    //   process.env.TEST_EMAIL_MERCH + 1,
    //   process.env.TEST_PSW_MERCH + 1,
    // )
    // merCred = resMerch
  })

  describe('GET /order/merchant get order for merchant', () => {
    it('Test get order for merchant', async () => {
      const token = await getIdToken(merCred.user)
      const resp = await axios.get('/order/merchant', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      console.info(JSON.stringify(resp.data, undefined, 2))
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('POST /order/ create new order', () => {
    it('Test Create Order from user', async () => {
      const token = await getIdToken(cusCred.user)
      const resp = await axios.post(
        '/',
        {
          order_type: 'BIKE',
          payment_type: 'DANA',
          gross_amount: 75000,
          net_amount: 75000,
          total_amount: 75000,
          shipping_cost: 75000,
          // product: [
          //   {
          //     quantity: 1,
          //     product_id: 'uniqadasdw',
          //   },
          // ],
          location: {
            latitude: -6.1231,
            longitude: 112.1231,
            address: 'Jl. Cinta 69',
          },
          destination: {
            latitude: -6.1231,
            longitude: 112.1231,
            address: 'Jl. Merkeda 12',
          },
          // discount_id: 'asdasda',
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
  //driver
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
    it('Test assign driver id on order idd', async () => {
      const token = await getIdToken(driCred.user)
      const resp = await axios.put(
        '/driver/sign/clrrexkyv0008k63341mddk1q',
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
