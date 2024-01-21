'use client'

import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useRef } from 'react'

export function OAuthClient() {
  const router = useRouter()
  const queryParams = useSearchParams()

  const authCode = queryParams.get('authCode')
  const state = queryParams.get('state')
  const dialogRef = useRef<HTMLDialogElement>(null)

  useEffect(() => {
    if (authCode && state) {
      dialogRef.current?.showModal()
      fetch('/api/callback', {
        method: 'POST',
        body: JSON.stringify({ authCode: authCode, state: state }),
      })
        .then((resp) => resp.json())
        .then(() => {
          dialogRef.current?.close()
          router.push('/oauth/success')
        })
        .catch(() => {
          dialogRef.current?.close()
        })
    } else {
      // router.push('/')
    }
  }, [authCode, router, state])

  return (
    <main>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box">
          <div className="p-4 text-center">
            <div className={'btn btn-ghost'}>
              <span className={'loading loading-bars'}></span>
            </div>
          </div>
        </div>
      </dialog>
    </main>
  )
}
