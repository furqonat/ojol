/* eslint-disable @next/next/no-img-element */
'use client'

import { useSession } from 'next-auth/react'
import { useCallback, useEffect, useState } from 'react'
import { driver, driver_details } from '@prisma/client/users'
import { UrlService } from '../../services/url.service'

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
        `${process.env.NEXT_PUBLIC_PROD_BASE_URL}account/admin/driver`,
      )
        .addQuery('id', 'true')
        .addQuery('name', 'true')
        .addQuery('driver_details', 'true')
        .addQuery('orderBy', 'order')
        .addQuery('avatar', 'true')
        .addQuery('_count', 'true')
        .addQuery('type', 'ACTIVE')
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

  console.log('hi +', drivers)
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
