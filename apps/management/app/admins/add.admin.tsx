'use client'

import { useSession } from 'next-auth/react'
import React, { useEffect, useRef } from 'react'

export function AddAdmin() {
  const dialogRef = useRef<HTMLDialogElement>(null)
  const { data } = useSession()
  console.log(data?.user?.role)
  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleOnCreateAdmin(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
  }

  useEffect(() => {
    fetch(
      'http://localhost:3000/dev/admin/clpqfo57a0000ktpqf6vaqi1j?name=true&email=true',
      {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      },
    )
      .then((e) => e.json())
      .then(console.log)
  }, [data?.user.token])

  return (
    <div>
      <button className={'btn btn-outline btn-md'} onClick={handleOpenModal}>
        Add Admin
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add new admin</h3>
          <form onSubmit={handleOnCreateAdmin}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Name</span>
              </div>
              <input
                type="text"
                placeholder="Type here"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Email</span>
              </div>
              <input
                type={'email'}
                required={true}
                placeholder="Type here"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Password</span>
              </div>
              <input
                type="password"
                placeholder="Type here"
                className="input input-bordered w-full input-sm"
              />
            </label>
          </form>
        </div>
        <form method="dialog" className="modal-backdrop">
          <button>close</button>
        </form>
      </dialog>
    </div>
  )
}
