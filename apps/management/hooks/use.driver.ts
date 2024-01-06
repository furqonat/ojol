'use client'

import { useEffect, useState } from 'react'
import { Driver, drivers as d } from '../services'
import { collection, onSnapshot, query, where } from 'firebase/firestore'
import { useFirebase } from './use.firebase'

export function useDriver() {
  const [drivers, setDrivers] = useState<Driver[]>([])
  const { db } = useFirebase()

  useEffect(() => {
    if (db) {
      const q = query(collection(db, 'drivers'), where('isOnline', '==', true))
      const unsubscribe = onSnapshot(q, (snapshot) => {
        setDrivers(d.fromFirestore(snapshot))
      })
      return () => {
        unsubscribe()
      }
    } else {
      return () => {}
    }
  }, [db])

  return {
    drivers,
  }
}
