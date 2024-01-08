'use client'

import { useSession } from 'next-auth/react'
import { useState, useEffect } from 'react'
import { AddDiscount } from './add.discount'
import { discount } from '@prisma/client/users'
import { DeleteDiscount } from './delete.discount'

export function Discount() {
  const { data } = useSession()
  const [discounts, setDiscounts] = useState<discount[]>([])

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/discount'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setDiscounts)
    }
  }, [data?.user?.token])

  return (
    <section>
      <div className={'flex w-full items-center'}>
        <h2 className={'text-xl font-semibold flex-1'}>Discount</h2>
        <AddDiscount />
      </div>
      <div className={'flex flex-col gap-6'}>
        {discounts?.map((item) => {
          return (
            <div key={item.id} className={'card shadow-md'}>
              <div className={'card-body'}>
                <div className={'flex flex-row w-full'}>
                  <div className={'flex-1'}>
                    <h3 className={'card-title capitalize'}>{item.code}</h3>
                    <div className={'flex gap-2 items-center'}>
                      <span className={'badge'}>
                        {Number(item.amount).toLocaleString('id-ID', {
                          style: 'currency',
                          currency: 'IDR',
                        })}
                      </span>
                      <span className={'badge'}>
                        {new Date(item.expired_at!).toLocaleDateString(
                          'id-ID',
                          {
                            day: '2-digit',
                            month: 'long',
                            year: 'numeric',
                          },
                        )}
                      </span>
                    </div>
                  </div>
                  <div className={'flex gap-2 items-center'}>
                    {/* <EditKorlapFee data={item} /> */}
                    {/* <DeleteKorlapFee id={item.id} /> */}
                    <DeleteDiscount id={item.id} />
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
