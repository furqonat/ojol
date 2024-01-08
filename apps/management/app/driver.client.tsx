/* eslint-disable @next/next/no-img-element */
'use client'

import { useSession } from 'next-auth/react'
import { useCallback, useEffect, useState } from 'react'
import { UrlService } from '../services'
import { driver, driver_details } from '@prisma/client/users'

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
        .addQuery('type', 'ACTIVE')
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
      <section className={'mt-5'}>
        <h2 className={'text-lg md:text-xl lg:text-2xl font-semibold'}>
          Top Driver
        </h2>
      </section>
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
                <th></th>
              </tr>
            </thead>
            <tbody>
              {/* row 1 */}
              {drivers &&
                drivers?.data?.map((item, index) => {
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
                      <th>
                        <button className="btn btn-ghost btn-xs">
                          details
                        </button>
                      </th>
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
