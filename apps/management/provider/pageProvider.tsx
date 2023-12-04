'use client'

import { usePathname } from 'next/navigation'
import React from 'react'
import { Navbar, Sidebar } from '../components'
import { SessionProvider } from 'next-auth/react'

type ProviderType = {
  children: React.ReactNode
}
export function PageProvider({ children }: ProviderType) {
  const pathname = usePathname()
  return (
    <SessionProvider>
      <div>
        {!pathname.startsWith('/auth') ? (
          <div className={'flex max-h-screen'}>
            <div
              className={
                'hidden md:flex flex-col overflow-y-scroll hide-scrollbar min-h-screen'
              }
            >
              <Sidebar />
            </div>
            <div className={'flex flex-col flex-1'}>
              <Navbar />
              {children}
            </div>
          </div>
        ) : (
          children
        )}
      </div>
    </SessionProvider>
  )
}
