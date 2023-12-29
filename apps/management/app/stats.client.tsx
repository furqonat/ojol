'use client'

import { useCallback, useEffect, useState } from 'react'
import { UrlService } from '../services'
import { useSession } from 'next-auth/react'

type StatsProp = {
  filter?: 'day' | 'month' | 'year' | ''
}

type TotalState = {
  customer: number
  driver: number
  merchant: number
  transactions: number
}
export function Stats(props: StatsProp) {
  const { data } = useSession()
  const [total, setTotal] = useState<TotalState | null>(null)

  const fetchTotal = useCallback(async () => {
    if (data?.user.token) {
      const baseUrl = process.env.NEXT_PUBLIC_DEV_BASE_URL + '/dev/admin/'
      const endpoints = ['customer', 'driver', 'merchant', 'transactions']

      const requests = endpoints.map((endpoint) => {
        const url = new UrlService(`${baseUrl}${endpoint}/`)
          .addQuery('createdIn', props.filter)
          .addQuery('take', '10')
        return fetch(url.build(), {
          headers: {
            Authorization: `Bearer ${data.user.token}`,
          },
        })
      })

      const responses = await Promise.all(requests)
      const jsonResponses = await Promise.all(
        responses.map((res) => res.json()),
      )

      console.log(jsonResponses)

      const totalData = jsonResponses.reduce((acc, json, index) => {
        acc[endpoints[index]] = json.total
        return acc
      }, {})

      setTotal(totalData)
    }
  }, [data?.user.token, props.filter])

  useEffect(() => {
    fetchTotal().then()
  }, [fetchTotal])

  return (
    <section className={'grid grid-cols-2 lg:grid-cols-4 gap-4'}>
      <div
        className={
          'stats stats-vertical shadow-sm border border-gray-200 border-solid'
        }
      >
        <div className="stat">
          <div className={'stat-title'}>Total Users</div>
          <div className={'stat-value text-2xl'}>{total?.customer}</div>
          <div className={'stat-desc'}>total users all time</div>
        </div>
      </div>
      <div
        className={
          'stats stats-vertical shadow-sm border border-gray-200 border-solid'
        }
      >
        <div className="stat">
          <div className={'stat-title'}>Total Drivers</div>
          <div className={'stat-value text-2xl'}>{total?.driver}</div>
          <div className={'stat-desc'}>total drivers all time</div>
        </div>
      </div>
      <div
        className={
          'stats stats-vertical shadow-sm border border-gray-200 border-solid'
        }
      >
        <div className="stat">
          <div className={'stat-title'}>Total Merchants</div>
          <div className={'stat-value text-2xl'}>{total?.merchant}</div>
          <div className={'stat-desc'}>total merchants all time</div>
        </div>
      </div>
      <div
        className={
          'stats stats-vertical shadow-sm border border-gray-200 border-solid'
        }
      >
        <div className="stat">
          <div className={'stat-title'}>Total Transactions</div>
          <div className={'stat-value text-2xl'}>{total?.transactions}</div>
          <div className={'stat-desc'}>total transactions in month</div>
        </div>
      </div>
    </section>
  )
}
