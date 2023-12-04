'use client'

import { useSession } from 'next-auth/react'
import { useRef } from 'react'

export function AddAdmin() {
  const dialogRef = useRef<HTMLDialogElement>(null)
  const { data } = useSession()
  console.log(data?.user?.role)
  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  return (
    <div>
      <button className={'btn btn-outline btn-md'} onClick={handleOpenModal}>
        Add Admin
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box">
          <h3 className="font-bold text-lg">Add new admin</h3>
          <p className="py-4">Press ESC key or click outside to close</p>
        </div>
        <form method="dialog" className="modal-backdrop">
          <button>close</button>
        </form>
      </dialog>
    </div>
  )
}
