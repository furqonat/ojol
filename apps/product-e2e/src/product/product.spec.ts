import axios, { AxiosError, HttpStatusCode } from 'axios'
import { initializeApp } from 'firebase/app'
import { UserCredential, getAuth, getIdToken } from 'firebase/auth'
import {
  customerSignIn,
  driverSignIn,
  getFirebaseConfig,
  merchantSignIn,
} from '@lugo/firebase-e2e'

import { Prisma } from '@prisma/client/users'

describe('Test e2e product services', () => {
  let merchCred: UserCredential
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

    const resMerch = await merchantSignIn(
      auth,
      process.env.TEST_EMAIL_MERCH,
      process.env.TEST_PSW_MERCH,
    )
    merchCred = resMerch

    const resDri = await driverSignIn(
      auth,
      process.env.EMAILDRIVER,
      process.env.PASSWORDDRIVER,
    )
    driCred = resDri
  })
  describe('GET /product', () => {
    it('should return status ok using merchant cred', async () => {
      const token = await getIdToken(merchCred.user)
      const res = await axios.get<{ status: number }>(
        `/product?id=true&name=true&_count={select: {customer_product_review: true}}`,
        {
          headers: { Authorization: `Bearer ${token}` },
        },
      )
      console.info(res.data)
      expect(res.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('GET /product', () => {
    it('should return status ok using customer cred', async () => {
      const token = await getIdToken(cusCred.user)
      const res = await axios.get(`/product`, {
        headers: { Authorization: `Bearer ${token}` },
      })

      expect(res.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('GET /product', () => {
    it('should return status unauhtorized using driver cred', async () => {
      try {
        const token = await getIdToken(driCred.user)
        await axios.get(`/product`, {
          headers: { Authorization: `Bearer ${token}` },
        })
      } catch (e) {
        expect(e).toBeInstanceOf(AxiosError)
      }
    })
  })

  describe('POST /product', () => {
    it('should return status created create product', async () => {
      const token = await getIdToken(merchCred.user)
      const res = await axios.post<
        unknown,
        { status: number },
        Omit<Prisma.productCreateInput, 'merchant'>
      >(
        `/product`,
        {
          name: 'Test product',
          price: 100000,
        },
        {
          headers: { Authorization: `Bearer ${token}` },
        },
      )
      expect(res.status).toBe(HttpStatusCode.Created)
    })
  })
  describe('POST /product', () => {
    it('should return status ok update product', async () => {
      const token = await getIdToken(merchCred.user)
      const res = await axios.put<
        unknown,
        { status: number },
        Omit<Prisma.productUpdateInput, 'merchant'>
      >(
        `/product/clq7lwafe0000dev6sha807w5`,
        {
          name: 'Test product 1',
          price: 100000,
        },
        {
          headers: { Authorization: `Bearer ${token}` },
        },
      )
      expect(res.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('GET /product/favorite', () => {
    it('should return status ok update product', async () => {
      const token = await getIdToken(cusCred.user)
      const res = await axios.get(
        `/product/favorite/clq7lwafe0000dev6sha807w5`,
        {
          headers: { Authorization: `Bearer ${token}` },
        },
      )
      expect(res.status).toBe(HttpStatusCode.Ok)
    })
  })
})
