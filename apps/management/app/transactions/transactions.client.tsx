/* eslint-disable @next/next/no-img-element */
'use client'

import {
  merchant,
  order,
  order_detail,
  order_item,
  product,
  transactions,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'

interface Product extends product {
  merchant: merchant
}

interface OrderItems extends order_item {
  product: Product
}

interface Order extends order {
  order_items: OrderItems[]
  order_detail: order_detail
}

interface Trx extends transactions {
  order: Order
}

type Response = {
  data: Trx[]
  total: number
}

export function Transactions() {
  const [transactions, setTransactions] = useState<Response | null>(null)
  const { data } = useSession()

  useEffect(() => {
    if (data?.user?.token) {
      fetch(`${process.env.NEXT_PUBLIC_PROD_BASE_URL}trx/`, {
        headers: {
          Authorization: `Bearer ${data.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setTransactions)
    }
  }, [data?.user.token])
  return (
    <section className={'grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3'}>
      {transactions?.data?.map((trx) => {
        return (
          <div key={trx.id} className={'card shadow-md'}>
            <figure className={'max-h-[200px]'}>
              <img
                height={200}
                src={`https://placehold.co/800?text=TRX+${trx.order.order_type}&font=roboto`}
                alt="Shoes"
              />
            </figure>
            <div className={'card-body flex flex-row items-center'}>
              <div className={'flex flex-col gap-3 flex-1'}>
                <table className={'table'}>
                  <tbody>
                    <tr>
                      <td className={'font-semibold'}>
                        Transactions ID {'  '}
                      </td>
                      <td> {trx.id}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Order ID</td>
                      <td> {trx.order.id}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Created At</td>
                      <td>
                        {' '}
                        {new Date(trx.created_at).toLocaleDateString('id-ID', {
                          year: 'numeric',
                          month: 'long',
                          day: 'numeric',
                          hour: 'numeric',
                          minute: 'numeric',
                          second: 'numeric',
                        })}
                      </td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Payment Type</td>
                      <td> {trx.order.payment_type}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Status</td>
                      <td> {trx.status}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Total Payment</td>
                      <td>
                        {' '}
                        {Number(trx.order.total_amount).toLocaleString(
                          'id-ID',
                          {
                            style: 'currency',
                            currency: 'IDR',
                          },
                        )}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )
      })}
    </section>
  )
}
