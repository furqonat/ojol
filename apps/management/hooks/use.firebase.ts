'use client'

import { initializeApp, getApp } from 'firebase/app'
import { Firestore, getFirestore } from 'firebase/firestore'
import { useEffect, useState } from 'react'

const fr = initializeApp({
  apiKey: process.env.NEXT_PUBLIC_API_KEY,
  authDomain: process.env.NEXT_PUBLIC_AUTH_DOMAIN,
  projectId: process.env.NEXT_PUBLIC_PROJECT_ID,
  storageBucket: process.env.NEXT_PUBLIC_STORAGE_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_MESSAGING_SENDER_ID,
  appId: process.env.NEXT_PUBLIC_APP_ID,
  measurementId: process.env.NEXT_PUBLIC_MEASUREMENT_ID,
})

export function useFirebase() {
  const [app, setApp] = useState<ReturnType<typeof getApp> | null>(null)
  const [db, setDb] = useState<Firestore | null>(null)

  useEffect(() => {
    setApp(fr)
    setDb(getFirestore(fr))
  }, [])

  return {
    app,
    db,
  }
}
