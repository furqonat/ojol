/* eslint-disable @next/next/no-img-element */
'use client'

import { isSuperAdmin } from '../../services/app.service'
import {
  admin,
  admin_wallet,
  driver,
  driver_details,
  referal,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'
import { UrlService } from '../../services/url.service'
import { Finance } from './finance'

type Role = {
  id: string
  name: string
}
interface Driver extends driver {
  _count: {
    order: number
  }
  driver_details: driver_details
}

type Referal = referal & {
  driver: Driver[]
  _count: {
    driver: number
  }
}

type Admin = admin & {
  role: Role[]
  referal?: Referal
  admin_wallet?: admin_wallet
}

export function Client() {
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
        .addQuery('id_card', 'true')
        .addQuery('id_card_images', 'true')
        .addQuery('bank_number', 'true')
        .addQuery('bank_name', 'true')
        .addQuery('bank_holder', 'true')
        .addQuery('phone_number', 'true')
        .addQuery('admin_wallet', 'true')
        .addQuery(
          'referal',
          '{select: { driver: {include: {driver_details:true, _count: {select: {order:true}}}}, _count: {select: {driver: {where: {status: "ACTIVE"}}}}}}',
        )
      fetch(encodeURI(url.build()), {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setAdmins)
    }
  }, [data?.user.token])

  console.log(admins)

  return (
    <section className={'flex flex-col gap-6'}>
      {isSuperAdmin(data) ? (
        <>
          {admins?.map((item) => {
            if (item?.referal) {
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
                              <div
                                className="badge badge-neutral"
                                key={role.id}
                              >
                                {role.name}
                              </div>
                            )
                          })}
                          <span>Total Driver {item.referal._count.driver}</span>
                        </div>
                      </div>
                      <div className={'card-actions'}>
                        <DetailsDrivers data={item.referal.driver} />
                        <DetailsAdmin data={item} />
                      </div>
                    </div>
                  </div>
                </div>
              )
            } else {
              return null
            }
          })}
        </>
      ) : (
        <Finance />
      )}
    </section>
  )
}

function DetailsDrivers(props: { data: Driver[] }) {
  const dialogRef = useRef<HTMLDialogElement>(null)
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
            d="M13.19 8.688a4.5 4.5 0 0 1 1.242 7.244l-4.5 4.5a4.5 4.5 0 0 1-6.364-6.364l1.757-1.757m13.35-.622 1.757-1.757a4.5 4.5 0 0 0-6.364-6.364l-4.5 4.5a4.5 4.5 0 0 0 1.242 7.244"
          />
        </svg>
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <div className={'flex flex-col gap-6'}>
            <h2>List driver linked by this admin</h2>
            <table className="table">
              {/* head */}
              <thead>
                <tr>
                  <th>No</th>
                  <th>Name</th>
                  <th>Total Jobs</th>
                </tr>
              </thead>
              <tbody>
                {props.data &&
                  props?.data?.map((item, index) => {
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
                        <td>{item._count?.order}</td>
                      </tr>
                    )
                  })}
              </tbody>
            </table>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex gap-6'}>
              <button className="btn btn-sm">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}

function DetailsAdmin(props: { data: Admin }) {
  const dialogRef = useRef<HTMLDialogElement>(null)
  return (
    <>
      <button
        className={'btn btn-outline btn-sm'}
        onClick={(e) => {
          dialogRef.current?.showModal()
        }}
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
            d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 0 0 2.25-2.25V6.75A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25v10.5A2.25 2.25 0 0 0 4.5 19.5Zm6-10.125a1.875 1.875 0 1 1-3.75 0 1.875 1.875 0 0 1 3.75 0Zm1.294 6.336a6.721 6.721 0 0 1-3.17.789 6.721 6.721 0 0 1-3.168-.789 3.376 3.376 0 0 1 6.338 0Z"
          />
        </svg>
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <div className={'flex flex-col gap-6'}>
            <h2>Detail Admin</h2>
            <label>
              <div className="label">
                <span className="label-text-alt">Name</span>
              </div>
              <input
                className={'input input-bordered input-sm w-full'}
                readOnly={true}
                defaultValue={props.data.name}
              />
            </label>
            <label>
              <div className="label">
                <span className="label-text-alt">Balance</span>
              </div>
              <input
                className={'input input-bordered input-sm w-full'}
                readOnly={true}
                defaultValue={props.data.admin_wallet?.balance}
              />
            </label>
            <label>
              <div className="label">
                <span className="label-text-alt">Account Bank Owner Name</span>
              </div>
              <input
                className={'input input-bordered input-sm w-full'}
                readOnly={true}
                defaultValue={props.data?.bank_holder ?? ''}
              />
            </label>
            <label>
              <div className="label">
                <span className="label-text-alt">Bank Name</span>
              </div>
              <input
                className={'input input-bordered input-sm w-full'}
                readOnly={true}
                defaultValue={props.data?.bank_name ?? ''}
              />
            </label>
            <label>
              <div className="label">
                <span className="label-text-alt">Bank Number</span>
              </div>
              <input
                className={'input input-bordered input-sm w-full'}
                readOnly={true}
                defaultValue={props.data?.bank_number ?? ''}
              />
            </label>
            <label>
              <div className="label">
                <span className="label-text-alt">ID Card</span>
              </div>
              <input
                className={'input input-bordered input-sm w-full'}
                readOnly={true}
                defaultValue={props.data.id_card ?? ''}
              />
            </label>
            <label>
              <div className="label">
                <span className="label-text-alt">ID Card Images</span>
              </div>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={props.data?.id_card_images ?? ''} alt={'ktp'} />
            </label>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex gap-6'}>
              <button className="btn btn-sm">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
