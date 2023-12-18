import { customerSignIn, getFirebaseConfig } from '@lugo/firebase-e2e'
import axios from 'axios'
import { initializeApp } from 'firebase/app'
import { UserCredential, getAuth, getIdToken } from 'firebase/auth'

describe('Test cart service', () => {
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
  describe('GET /cart', () => {
    it('should return a 200', async () => {
      const token = await getIdToken(cusCred.user)
      const res = await axios.get(`/dev/cart`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })

      console.info(JSON.stringify(res.data, undefined, 2))

      expect(res.status).toBe(200)
    })
  })
  describe('POST /cart', () => {
    it('should return a 200', async () => {
      const token = await getIdToken(cusCred.user)
      const res = await axios.post(
        `/dev/cart`,
        {
          productId: 'clq7m09gj0001dev6y4kcvpvp',
          quantity: 1,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )

      expect(res.status).toBe(201)
    })
  })
  describe('PUT /cart', () => {
    it('should return a 200', async () => {
      const token = await getIdToken(cusCred.user)
      const res = await axios.put(
        `/dev/cart`,
        {
          cartItemId: 'clq7ltn610000yn3zrmm352ix',
          quantity: 0,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        },
      )

      expect(res.status).toBe(200)
    })
  })
})
