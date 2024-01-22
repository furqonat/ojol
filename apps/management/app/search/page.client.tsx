'use client'

import {
  customer,
  driver,
  merchant,
  order,
  transactions,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useRef, useState } from 'react'

type Trx = transactions & {
  order: order
}

type SearchResult = {
  merchant: merchant[]
  customer: customer[]
  driver: driver[]
  order: order[]
  transaction: Trx[]
}

export function SearchClient() {
  const { data } = useSession()
  const query = useSearchParams()
  const search = query.get('q')
  const router = useRouter()

  const [searchResult, setSearchResult] = useState<SearchResult | null>(null)

  useEffect(() => {
    if (search) {
      const url =
        process.env.NEXT_PUBLIC_GATE_BASE_URL + `/portal/search?q=${search}`
      fetch(url, {
        method: 'GET',
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setSearchResult)
    } else {
      router.push('/')
    }
  }, [search, router, data?.user?.token])

  console.log(searchResult)
  return (
    <div role="tablist" className="tabs tabs-lifted">
      <input
        defaultChecked
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Transactions"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        {searchResult?.transaction?.map((item) => {
          return (
            <div
              className={'card w-full card-side shadow-sm items-center'}
              key={item.id}
            >
              <div className={'card-body'}>
                <h3 className={'card-title'}>{item.id}</h3>
                <span>{item.type}</span>
              </div>
              <div className={'card-actions'}>
                <ViewDetailTrx transaction={item} />
              </div>
            </div>
          )
        })}
      </div>

      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Order"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        Tab content 2
      </div>

      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Customer"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        Tab content 3
      </div>
      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Merchant"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        Tab content 4
      </div>
      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Merchant"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        Tab content 5
      </div>
    </div>
  )
}

function ViewDetailTrx(props: { transaction: Trx }) {
  const dialogRef = useRef<HTMLDialogElement>(null)
  const { transaction: trx } = props
  return (
    <>
      <button className={'btn'} onClick={() => dialogRef.current?.showModal()}>
        View
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <h3 className="font-bold text-lg">Update Merchant</h3>
          <div key={trx.id} className={'card shadow-md'}>
            <figure className={'max-h-[200px]'}>
              {/* eslint-disable-next-line @next/next/no-img-element */}
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
          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
