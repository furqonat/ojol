/* eslint-disable @next/next/no-img-element */
'use client'

import { useSession } from 'next-auth/react'
import React, { useCallback, useEffect, useRef, useState } from 'react'
import { Prisma, driver, driver_details } from '@prisma/client/users'
import { UrlService } from '../../services/url.service'
import Select, { SingleValue } from 'react-select'

interface Driver extends driver {
  driver_details: driver_details
  _count: {
    order: number
  }
}
type Response = {
  data: Driver[]
  total: number
}

const badge = ['BASIC', 'REGULAR', 'PREMIUM']

export function Driver() {
  const { data } = useSession()
  const [drivers, setDrivers] = useState<Response | null>(null)

  const fetchDriver = useCallback(async () => {
    if (data?.user.token) {
      const url = new UrlService(
        `${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/driver`,
      )
        .addQuery('id', 'true')
        .addQuery('name', 'true')
        .addQuery('driver_details', 'true')
        .addQuery('orderBy', 'order')
        .addQuery('avatar', 'true')
        .addQuery('_count', 'true')
        .addQuery('status', 'true')
      console.log(url.build())
      fetch(url.build(), {
        headers: {
          Authorization: `Bearer ${data.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setDrivers)
    }
  }, [data?.user.token])

  useEffect(() => {
    fetchDriver().then()
  }, [fetchDriver])

  return (
    <section>
      <section>
        <div className="overflow-x-auto">
          <table className="table">
            {/* head */}
            <thead>
              <tr>
                <th>No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Total Jobs</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {/* row 1 */}
              {drivers?.data.map((item, index) => {
                return (
                  <tr key={item.id}>
                    <th>{index + 1}</th>
                    <td>
                      <div className="flex items-center gap-3">
                        <div className="avatar">
                          <div className="mask mask-squircle w-12 h-12">
                            <img
                              src={item.avatar ?? '/lugo.png'}
                              alt="Avatar Tailwind CSS Component"
                            />
                          </div>
                        </div>
                        <div>
                          <div className="font-bold">{item?.name}</div>
                          <div className="text-sm opacity-50">
                            {item.driver_details?.badge}
                          </div>
                        </div>
                      </div>
                    </td>
                    <td>
                      {item.driver_details?.address}
                      <br />
                      <span className="badge badge-ghost badge-sm capitalize">
                        {item.driver_details?.driver_type.toLowerCase()} Driver
                      </span>
                    </td>
                    <td>{item._count?.order}</td>
                    <td className={'flex flex-row gap-6 items-center'}>
                      <Actions
                        checked={item.status === 'ACTIVE'}
                        id={item.id}
                      />
                      <DeleteDriver id={item.id} />
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      </section>
    </section>
  )
}

function DeleteDriver(props: { id: string }) {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)
  function handleDelete(e: React.MouseEvent<HTMLButtonElement>) {
    e.preventDefault()
    const url = `${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/driver/${props.id}`
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
      <dialog ref={dialogRef} className={'modal'}>
        <form method="dialog">
          <div className="modal-box">
            <h3 className="font-bold text-lg">
              Are you sure you want to delete this driver?
            </h3>
            <div className="modal-action">
              <button className="btn btn-sm btn-primary" onClick={handleDelete}>
                Delete
              </button>
              <button
                className="btn btn-sm"
                onClick={() => {
                  dialogRef.current?.close()
                }}
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

function Actions(props: { checked: boolean; id: string }) {
  const { data } = useSession()
  const [status, setStatus] = useState(props.checked)
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
    const url =
      process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL + `admin/driver/${props.id}`
    const body: Prisma.driverUpdateInput = {
      status: checked === true ? 'ACTIVE' : 'BLOCK',
    }
    fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      e.json().then(console.log)
      if (e.ok) {
        setStatus(true)
        window.location.reload()
      } else {
        setStatus(false)
      }
    })
  }

  function handleChangeBadge(
    newValue: SingleValue<{
      label: string
      value: string
    }>,
  ) {
    const url =
      process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL + `admin/driver/${props.id}`
    const body: Prisma.driverUpdateInput = {
      driver_details: {
        update: {
          badge: newValue?.value as 'BASIC' | 'REGULAR' | 'PREMIUM',
        },
      },
    }
    fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      if (e.ok) {
        setStatus(true)
      } else {
        setStatus(false)
      }
    })
  }

  return (
    <>
      <button
        className="btn btn-sm btn-ghost"
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
            d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L6.832 19.82a4.5 4.5 0 0 1-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 0 1 1.13-1.897L16.863 4.487Zm0 0L19.5 7.125"
          />
        </svg>
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <h3 className="font-bold text-lg">Update Driver</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex gap-6 mt-6 items-center'}>
              <h4 className={'font-semibold flex-1'}>Status Driver</h4>
              <input
                type="checkbox"
                className="toggle"
                checked={status}
                onChange={handleChangeToggle}
              />
            </div>
            <Select
              onChange={handleChangeBadge}
              options={badge.map((item) => {
                return {
                  label: item,
                  value: item,
                }
              })}
            />
          </div>
          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
