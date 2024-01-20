'use client'

import { UrlService } from '../../services/url.service'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'
import { admin } from '@prisma/client/users'

type Role = {
  id: string
  name: string
}

type Admin = admin & {
  role: Role[]
}

export function Admin() {
  const { data } = useSession()

  const [admins, setAdmins] = useState<Admin[]>([])

  useEffect(() => {
    if (data?.user.token) {
      const url = new UrlService(
        `${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/`,
      )
        .addQuery('id', 'true')
        .addQuery('name', 'true')
        .addQuery('email', 'true')
        .addQuery('avatar', 'true')
        .addQuery('status', 'true')
        .addQuery('role', 'true')
      fetch(url.build(), {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setAdmins)
    }
  }, [data?.user.token])

  return (
    <section className={'flex flex-col gap-6'}>
      {admins?.map((item) => {
        return (
          <div
            key={item.id}
            className={'card w-full shadow-sm p-3 rounded-none'}
          >
            <div className={'card-body'}>
              <div className={'flex gap-6 items-center'}>
                <div className={'flex-1'}>
                  <h3 className={'card-title'}>{item.name}</h3>
                  <span>{item.email}</span>
                  <div className={'flex flex-row gap-4 items-center'}>
                    {item.role?.map((role) => {
                      return (
                        <div className="badge badge-neutral" key={role.id}>
                          {role.name}
                        </div>
                      )
                    })}
                  </div>
                </div>
                <div className={'card-actions'}>
                  {data?.user.role[0]?.name === 'SUPERADMIN' ? (
                    <div className={'flex flex-row gap-6'}>
                      <ToggleButton
                        status={item.status}
                        token={data?.user.token}
                        disable={item.id == data?.user.id}
                      />
                      <DeleteAdmin id={item.id} />
                    </div>
                  ) : null}
                </div>
              </div>
            </div>
          </div>
        )
      })}
    </section>
  )
}

// detele admin
function DeleteAdmin(props: { id: string }) {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleDelete(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    const url = `${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/${props.id}`
    fetch(url, {
      method: 'DELETE',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
    })
      .then((e) => {
        if (e.ok) {
          dialogRef.current?.close()
          window.location.reload()
        }
      })
      .catch(console.log)
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  return (
    <>
      <button
        className={'btn btn-outline btn-sm'}
        onClick={() => dialogRef.current?.showModal()}
      >
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

      <dialog ref={dialogRef} className="modal modal-bottom sm:modal-middle">
        <form method={'dialog'} onSubmit={handleDelete}>
          <div className="modal-box">
            <h3 className="font-bold text-lg">Delete Admin</h3>
            <p className="py-4">Are you sure you want to delete this admin?</p>
            <div className="modal-action">
              <button type="submit" className="btn btn-error btn-outline">
                Delete
              </button>
              <button
                type="button"
                className="btn btn-ghost"
                onClick={handleCloseModal}
              >
                Cancel
              </button>
            </div>
          </div>
        </form>
      </dialog>
    </>
  )
}

function ToggleButton(props: {
  status: boolean
  disable: boolean
  token?: string
}) {
  const [status, setStatus] = useState(props.status)

  function handleChangeStatus(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
  }
  return (
    <input
      disabled={props.disable}
      type={'checkbox'}
      className={'toggle toggle-success'}
      checked={status}
      onChange={handleChangeStatus}
    />
  )
}
