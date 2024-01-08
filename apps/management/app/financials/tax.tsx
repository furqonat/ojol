'use client'

import { tax } from '@prisma/client/users'
import { AddTax } from './add.tax'
import { useSession } from 'next-auth/react'
import { useState, useEffect } from 'react'
import { DeleteTax } from './delete.tax'
import { EditTax } from './edit.tax'

export function Tax() {
  const { data } = useSession()
  const [tax, setTax] = useState<tax[]>([])

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/tax'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setTax)
    }
  }, [data?.user?.token])
  return (
    <section>
      <div className={'flex w-full items-center'}>
        <h2 className={'text-xl font-semibold flex-1'}>Tax PPH & PPN</h2>
        {/* <AddDiscount /> */}
        <AddTax />
      </div>
      <div className={'flex flex-col gap-6'}>
        {tax?.map((item) => {
          return (
            <div key={item.id} className={'card shadow-md'}>
              <div className={'card-body'}>
                <div className={'flex flex-row w-full'}>
                  <div className={'flex-1'}>
                    <h3 className={'card-title capitalize'}>{item.tax_type}</h3>
                    <div className={'flex gap-2 items-center'}>
                      <span className={'badge'}>{item.amount} %</span>
                      <span className={'badge'}>{item.applied_for}</span>
                    </div>
                  </div>
                  <div className={'flex gap-2 items-center'}>
                    <EditTax data={item} />
                    <DeleteTax id={item.id} />
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
