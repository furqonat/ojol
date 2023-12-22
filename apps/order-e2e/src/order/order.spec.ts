import { customerSignIn, getFirebaseConfig } from '@lugo/firebase-e2e'
import axios, { HttpStatusCode } from 'axios'
import { initializeApp } from 'firebase/app'
import { UserCredential, getAuth, getIdToken } from 'firebase/auth'

describe('Test Autentication Api', () => {
  let cusCred: UserCredential
  beforeAll(async () => {
    const app = initializeApp(getFirebaseConfig())
    const auth = getAuth(app)
    const resCus = await customerSignIn(
      auth,
      process.env.EMAILCUSTOMER,
      process.env.PASSWORDCUSTOMER,
    )
    cusCred = resCus
  })

  describe('POST /order/', () => {
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
})
