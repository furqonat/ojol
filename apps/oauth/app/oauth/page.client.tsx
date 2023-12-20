'use client'

import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useRef } from 'react'

export function OAuthClient() {
  const router = useRouter()
  const queryParams = useSearchParams()

  const authCode = queryParams.get('auth_code')
  //   const [_, setIsLoading] = useState(true)
  const dialogRef = useRef<HTMLDialogElement>(null)

  useEffect(() => {
    if (authCode) {
      dialogRef.current?.showModal()
      //   fetch('/callback', {
      //     method: 'POST',
      //     body: JSON.stringify({ authCode: authCode }),
      //   })
      //     .then((resp) => resp.json())
      //     .then(() => {
      //       setIsLoading(false)
      //       dialogRef.current?.close()
      //     })
      //     .catch(() => {
      //       setIsLoading(false)
      //       dialogRef.current?.close()
      //     })
      // }
    } else {
      router.push('/')
    }
  }, [authCode, router])

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
