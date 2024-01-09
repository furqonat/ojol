import { Auth, getIdToken, signInWithEmailAndPassword } from 'firebase/auth'
import axios, { HttpStatusCode } from 'axios'
const firebaseConfig = {
  apiKey: process.env['API_KEY'],
  authDomain: process.env['AUTH_DOMAIN'],
  projectId: process.env['PROJECT_ID'],
  storageBucket: process.env['STORAGE_BUCKET'],
  messagingSenderId: process.env['MESSAGING_SENDER_ID'],
  appId: process.env['APP_ID'],
  measurementId: process.env['MEASUREMENT_ID'],
}

const baseUrl = 'https://auth.gentatechnology.com'

export function getFirebaseConfig(): object {
  return firebaseConfig
}

export async function customerSignIn(
  auth: Auth,
  email: string,
  password: string,
) {
  const cred = await signInWithEmailAndPassword(auth, email, password)
  const token = await getIdToken(cred.user)
  const res = await axios.post(
    `${baseUrl}/customer`,
    {},
    { headers: { Authorization: `Bearer ${token}` } },
  )
  if (res.status === HttpStatusCode.Created) {
    await getIdToken(cred.user, true)
    return cred
  } else {
    throw new Error('Unauhorized')
  }
}

export async function driverSignIn(
  auth: Auth,
  email: string,
  password: string,
) {
  const cred = await signInWithEmailAndPassword(auth, email, password)
  const token = await getIdToken(cred.user)
  const res = await axios.post(
    `${baseUrl}/driver`,
    {},
    { headers: { Authorization: `Bearer ${token}` } },
  )
  if (res.status === HttpStatusCode.Created) {
    await getIdToken(cred.user, true)
    return cred
  } else {
    throw new Error('Unauhorized')
  }
}

export async function merchantSignIn(
  auth: Auth,
  email: string,
  password: string,
) {
  const cred = await signInWithEmailAndPassword(auth, email, password)
  const token = await getIdToken(cred.user)
  const res = await axios.post(
    `${baseUrl}/merchant`,
    {},
    { headers: { Authorization: `Bearer ${token}` } },
  )
  if (res.status === HttpStatusCode.Created) {
    await getIdToken(cred.user, true)
    return cred
  } else {
    throw new Error('Unauhorized')
  }
}
