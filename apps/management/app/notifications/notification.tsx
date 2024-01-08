/* eslint-disable @next/next/no-img-element */
'use client'

import { promotion } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'

type Response = {
  data: promotion[]
  total: number
}

export function Notification() {
  const { data } = useSession()
  const [notifications, setNotifications] = useState<Response | null>(null)
  useEffect(() => {
    if (data?.user?.token) {
      fetch(`${process.env.NEXT_PUBLIC_GATE_BASE_URL}portal/promo`, {
        headers: {
          Authorization: `Bearer ${data.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setNotifications)
    }
  }, [data?.user?.token])

  return (
    <div className={'flex flex-col gap-6'}>
      {notifications?.data?.map((item) => {
        return (
          <div
            className={'card shadow-sm card-side items-center'}
            key={item.id}
          >
            <figure className={'max-w-[200px] rounded-md'}>
              <img
                className={'max-w-[200px] rounded-md'}
                src={item.image_url ?? '/lugo.png'}
                width={200}
                height={200}
                alt={item.title}
              />
            </figure>
            <div className={'card-body'}>
              <h3 className={'card-title'}>{item.title}</h3>
              <p>{item.description}</p>
            </div>
            <div className={'card-actions'}>
              <span className={'badge badge-primary'}>{item.app_type}</span>
            </div>
          </div>
        )
      })}
    </div>
  )
}
