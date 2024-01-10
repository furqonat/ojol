'use client'

import { service_fee } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'
import { AddNewServiceFee } from './add.service.fee'
import { DeleteServiceFee } from './delete.service.fee'
import { EditServiceFee } from './edit.service.fee'

type Response = {
  data: service_fee[]
}

export function ServiceFee() {
  const { data } = useSession()
  const [serviceFee, setServiceFee] = useState<Response | null>(null)

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/fee'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setServiceFee)
    }
  }, [data?.user?.token])

  return (
    <section>
      <div className={'flex w-full items-center'}>
        <h2 className={'text-xl font-semibold flex-1'}>Service Fee</h2>
        <AddNewServiceFee />
      </div>
      <div className={'flex flex-col gap-6'}>
        {serviceFee?.data?.map((item) => {
          return (
            <div key={item.id} className={'card shadow-md'}>
              <div className={'card-body'}>
                <div className={'flex flex-row w-full'}>
                  <div className={'flex-1'}>
                    <h3 className={'card-title capitalize'}>
                      {item.service_type.toLowerCase()}
                    </h3>
                    <div className={'flex gap-2 items-center'}>
                      {item.service_type === 'BIKE' ||
                      item.service_type === 'CAR' ? null : (
                        <span className={'badge'}>{item.account_type}</span>
                      )}
                      <span>{item.percentage} %</span>
                    </div>
                  </div>
                  <div className={'flex gap-2 items-center'}>
                    <EditServiceFee data={item} />
                    <DeleteServiceFee id={item.id} />
                  </div>
                </div>
              </div>
            </div>
          )
        })}
      </div>
    </section>
  )
}
