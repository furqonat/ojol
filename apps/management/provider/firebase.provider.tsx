'use client'

import React from 'react'
import { useFirebase } from '../hooks'

const Firebase = React.createContext<ReturnType<typeof useFirebase> | null>(
  null,
)

type Provider = {
  children?: React.ReactNode
}

export function FirebaseProvider({ children }: Provider) {
  return <Firebase.Provider value={useFirebase()}>{children}</Firebase.Provider>
}
