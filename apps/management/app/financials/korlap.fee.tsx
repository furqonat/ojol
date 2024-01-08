'use client'

import { useSession } from 'next-auth/react'
import { AddKorlapFee } from './add.korlap.fee'
import { useEffect, useState } from 'react'
import { korlap_fee } from '@prisma/client/users'
import { EditKorlapFee } from './edit.korlap.fee'
import { DeleteKorlapFee } from './delete.korlap.fee'

type Response = {
  data: korlap_fee[]
}

export function KorlapFee() {
  const { data } = useSession()
  const [serviceFee, setServiceFee] = useState<Response | null>(null)

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/portal'
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
        <h2 className={'text-xl font-semibold flex-1'}>Korlap & Korcap Fee</h2>
        <AddKorlapFee />
      </div>
      <div className={'flex flex-col gap-6'}>
        {serviceFee?.data?.map((item) => {
          return (
            <div key={item.id} className={'card shadow-md'}>
              <div className={'card-body'}>
                <div className={'flex flex-row w-full'}>
                  <div className={'flex-1'}>
                    <h3 className={'card-title capitalize'}>
                      {item.admin_type.toLowerCase()}
                    </h3>
                    <div className={'flex gap-2 items-center'}>
                      <span className={'badge'}>{item.admin_type}</span>
                      <span>{item.percentage} %</span>
                    </div>
                  </div>
                  <div className={'flex gap-2 items-center'}>
                    <EditKorlapFee data={item} />
                    <DeleteKorlapFee id={item.id} />
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
