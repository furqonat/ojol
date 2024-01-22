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
import { useEffect, useState } from 'react'

type SearchResult = {
  merchant: merchant[]
  customer: customer[]
  driver: driver[]
  order: order[]
  transaction: transactions[]
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
        Tab content 1
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
