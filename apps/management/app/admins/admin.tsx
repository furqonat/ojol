'use client'

import { UrlService } from '../../services/url.service'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'
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
        `${process.env.NEXT_PUBLIC_PROD_BASE_URL}account/admin/`,
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
                    <ToggleButton
                      status={item.status}
                      token={data?.user.token}
                      disable={item.id == data?.user.id}
                    />
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
