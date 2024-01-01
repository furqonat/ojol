/* eslint-disable @next/next/no-img-element */
'use client'

import { Prisma, merchant, merchant_details } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'
import { UrlService } from '../../services/url.service'
import Select, { SingleValue } from 'react-select'

const badge = ['BASIC', 'REGULAR', 'PREMIUM']

interface User extends merchant {
  _count: {
    products: number
  }
  products: {
    _count: {
      order_item: number
    }
  }
  details?: merchant_details
}

type Response = {
  data: User[]
  total: number
}

export function Merchants() {
  const [users, setUsers] = useState<Response | null>(null)
  const { data } = useSession()

  useEffect(() => {
    if (data?.user?.token) {
      const url = new UrlService(
        `${process.env.NEXT_PUBLIC_PROD_BASE_URL}account/admin/merchant/`,
      )
        .addQuery('id', 'true')
        .addQuery('name', 'true')
        .addQuery('_count', '{select:{products:true}}')
        .addQuery('products', '{select:{_count: true}}')
        .addQuery('status', 'true')
        .addQuery('avatar', 'true')
        .addQuery('details', '{select:{badge:true}}')
      fetch(encodeURI(url.build()), {
        headers: {
          Authorization: `Bearer ${data.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setUsers)
    }
  }, [data?.user?.token])

  console.log(users)
  return (
    <section>
      <div className="overflow-x-auto">
        <table className="table">
          {/* head */}
          <thead>
            <tr>
              <th>No</th>
              <th>Name</th>
              <th>Bage</th>
              <th>Total Product</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {/* row 1 */}
            {users?.data?.map((item, index) => {
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
                          {item?.status}{' '}
                        </div>
                      </div>
                    </div>
                  </td>
                  <td>
                    <span className="badge badge-primary badge-sm capitalize">
                      {item?.details?.badge}
                    </span>
                  </td>
                  <td>{item._count?.products}</td>
                  <td>
                    <Actions checked={item.status === 'ACTIVE'} id={item.id} />
                  </td>
                </tr>
              )
            })}
          </tbody>
        </table>
      </div>
    </section>
  )
}

function Actions(props: { checked: boolean; id: string }) {
  const { data } = useSession()
  const [status, setStatus] = useState(props.checked)
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    const url =
      process.env.NEXT_PUBLIC_PROD_BASE_URL +
      `account/admin/merchant/${props.id}`
    const body: Prisma.merchantUpdateInput = {
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
      if (e.ok) {
        setStatus(true)
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
      process.env.NEXT_PUBLIC_PROD_BASE_URL +
      `account/admin/merchant/${props.id}`
    const body: Prisma.merchantUpdateInput = {
      details: {
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
          <h3 className="font-bold text-lg">Update Merchant</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex gap-6 mt-6 items-center'}>
              <h4 className={'font-semibold flex-1'}>Status Merchant</h4>
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
