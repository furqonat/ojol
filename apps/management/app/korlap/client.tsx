'use client'

import { isSuperAdmin } from '../../services/app.service'
import { admin, referal } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'
import { UrlService } from '../../services/url.service'

type Role = {
  id: string
  name: string
}

type Referal = referal & {
  _count: {
    driver: number
  }
}

type Admin = admin & {
  role: Role[]
  referal?: Referal
}

export function Client() {
  const { data } = useSession()

  const [admins, setAdmins] = useState<Admin[]>([])

  useEffect(() => {
    if (data?.user.token) {
      const url = new UrlService(
        `${process.env.NEXT_PUBLIC_PROD_BASE_URL}account/admin/`,
      )
        .addQuery('id', 'true')
        .addQuery('name', 'true')
        .addQuery('email', 'true')
        .addQuery('avatar', 'true')
        .addQuery('status', 'true')
        .addQuery('role', 'true')
        .addQuery(
          'referal',
          '{select: {_count: {select: {driver: {where: {status: "ACTIVE"}}}}}}',
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
                        </div>
                      </div>
                      <div className={'card-actions'}>
                        <span>Total Driver {item.referal._count.driver}</span>
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
      ) : null}
    </section>
  )
}
