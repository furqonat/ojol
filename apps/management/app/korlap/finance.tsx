/* eslint-disable @next/next/no-img-element */
'use client'

import { isSuperAdmin } from '../../services/app.service'
import { UrlService } from '../../services/url.service'
import {
  admin,
  admin_wallet,
  driver,
  driver_details,
  referal,
  trx_admin,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'

type Driver = driver & {
  driver_details: driver_details
  _count: {
    order: number
  }
}

type Referal = referal & {
  _count: {
    driver: number
  }
  driver: Driver[]
}

type Admin = admin & {
  referal: Referal
  admin_wallet: admin_wallet
  trx_admin: trx_admin[]
}

export function Finance() {
  const { data } = useSession()
  const [admins, setAdmins] = useState<Admin | null>(null)

  useEffect(() => {
    if (data?.user?.token) {
      const url = new UrlService(
        process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL + `admin/${data?.user?.id}`,
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
        .addQuery('trx_admin', 'true')
        .addQuery(
          'referal',
          '{select: { driver: {include: {driver_details:true, _count: {select: {order:true}}}}, _count: {select: {driver: {where: {status: "ACTIVE"}}}}}}',
        )
      fetch(encodeURI(url.build()), {
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setAdmins)
    }
  }, [data?.user?.token, data?.user?.id])
  console.log(admins)
  return (
    <section className={'flex flex-col gap-6'}>
      {!isSuperAdmin(data) ? (
        <div className={'flex flex-row gap-6 w-full'}>
          <h2 className={'text-2xl font-semibold flex-1'}>My Stats</h2>
        </div>
      ) : null}
      <section className={'grid grid-cols-1 lg:grid-cols-2 gap-6'}>
        <div className={'flex flex-col gap-6'}>
          <section className={'grid grid-cols-2 gap-4'}>
            <div
              className={
                'stats stats-vertical shadow-sm border border-gray-200 border-solid'
              }
            >
              <div className="stat">
                <div className={'stat-title'}>My Balance </div>
                <div className={'stat-value text-2xl'}>
                  {admins?.admin_wallet?.balance != null
                    ? Number(admins?.admin_wallet?.balance)?.toLocaleString(
                        'id-ID',
                        {
                          style: 'currency',
                          currency: 'IDR',
                        },
                      )
                    : null}
                </div>
              </div>
            </div>
            <div
              className={
                'stats stats-vertical shadow-sm border border-gray-200 border-solid'
              }
            >
              <div className="stat">
                <div className={'stat-title'}>My Referal</div>
                <div className={'stat-value text-2xl'}>
                  {admins?.referal?._count?.driver}
                </div>
              </div>
            </div>
          </section>
          <h3 className={'font-semibold text-lg'}>Income history</h3>
          {admins &&
            admins?.trx_admin?.map((item) => {
              return (
                <div key={item.id} className={'card shadow-sm'}>
                  <div className={'card-body flex flex-row gap-6'}>
                    <div className={'flex-1'}>
                      <h3 className={'card-title'}>{item.trx_type}</h3>
                      <span>
                        {' '}
                        {new Date(item.created_at).toLocaleDateString('id-ID', {
                          year: 'numeric',
                          month: 'long',
                          day: '2-digit',
                        })}
                      </span>
                    </div>
                    <div>
                      <h3
                        className={`text-lg font-semibold ${
                          item.trx_type === 'WITHDRAW'
                            ? 'text-red-400'
                            : 'text-green-400'
                        }`}
                      >
                        {Number(item.amount).toLocaleString('id-ID', {
                          style: 'currency',
                          currency: 'IDR',
                        })}
                      </h3>
                    </div>
                  </div>
                </div>
              )
            })}
        </div>
        <div>
          <table className="table">
            <thead>
              <tr>
                <th>No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Total Jobs</th>
              </tr>
            </thead>
            <tbody>
              {admins &&
                admins?.referal?.driver?.map((item, index) => {
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
                          {item.driver_details?.driver_type.toLowerCase()}{' '}
                          Driver
                        </span>
                      </td>
                      <td>{item._count?.order}</td>
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
