'use client'

import { useSession } from 'next-auth/react'
import { useRef, useState } from 'react'

export function DeleteDiscount(props: { id: string }) {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)

  const [loading, setLoading] = useState(false)

  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  async function handleDeleteDiscount(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    const url = `${process.env.NEXT_PUBLIC_GATE_BASE_URL}portal/discount/${props.id}`
    const resp = await fetch(url, {
      method: 'DELETE',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
      },
    })

    if (resp.ok) {
      dialogRef.current?.close()
      window.location.reload()
    }
  }

  return (
    <div>
      <button className={'btn btn-outline btn-sm'} onClick={handleOpenModal}>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth={1.5}
          stroke="currentColor"
          className="w-4 h-4"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"
          />
        </svg>
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">
            Are you sure delete this discount fee?
          </h3>
          <form onSubmit={handleDeleteDiscount}>
            <div className={'flex flex-row-reverse mt-4 gap-5'}>
              <button className={'btn btn-sm btn-primary'}>
                {loading ? <span className={'loading loading-dots'} /> : null}
                OK
              </button>
              <button
                type="button"
                className={'btn btn-sm'}
                onClick={handleCloseModal}
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
        <form method="dialog" className="modal-backdrop">
          <button>close</button>
        </form>
      </dialog>
    </div>
  )
}
