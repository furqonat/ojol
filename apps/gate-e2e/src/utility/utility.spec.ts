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

  describe('GET /lugo/services/', () => {
    it('Test Create Order from user', async () => {
      const resp = await axios.get('/gate/services/')
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
  describe('POST /oauth/', () => {
    it('test apply token', async () => {
      const userId = cusCred.user.uid
      const resp = await axios.post(`/gate/oauth?customerId=${userId}`, {
        access_token: '3G7i3fcOr6l3AN6oJaRJfpiPnga5P5jbS8Er2000',
      })
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
    it('test generate signIn url', async () => {
      const token = await getIdToken(cusCred.user)
      const resp = await axios.get('/gate/oauth/', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
    it('test get dana profile', async () => {
      const token = await getIdToken(cusCred.user)
      const resp = await axios.get('/gate/oauth/profile/', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      console.info(resp.data)
      expect(resp.status).toBe(HttpStatusCode.Ok)
    })
  })
})
