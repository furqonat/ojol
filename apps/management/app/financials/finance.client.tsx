'use client'

import { trx_company } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'

type Balance = {
  total: number
  beforeFee: number
  bonusDriver: number
  netProfit: number
}

export function Finance() {
  const { data } = useSession()
  const [trx, setTrx] = useState<Balance | null>(null)
  const [type, setType] = useState('month')
  useEffect(() => {
    if (data?.user?.token) {
      const url =
        process.env.NEXT_PUBLIC_GATE_BASE_URL +
        `portal/trx/company?type=${type}`
      fetch(url, {
        method: 'GET',
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then((e: trx_company[]) => {
          const total = e.reduce((a, b) => {
            if (b.trx_type === 'ADJUSTMENT') {
              return a + b.amount
            } else {
              return a
            }
          }, 0)
          const beforeFee = e.reduce((a, b) => {
            if (b.trx_type === 'REDUCTION' && b.trx_from === 'ADMIN') {
              return a + b.amount
            } else {
              return a
            }
          }, 0)
          const bonusDriver = e.reduce((a, b) => {
            if (b.trx_type === 'REDUCTION' && b.trx_from == 'BONUS_DRIVER') {
              return a + b.amount
            } else {
              return a
            }
          }, 0)
          const bonusDriverGross = e.reduce((a, b) => {
            if (b.trx_type === 'ADJUSTMENT' && b.trx_from == 'DRIVER') {
              return a + b.amount
            } else {
              return a
            }
          }, 0)
          setTrx({
            beforeFee: total,
            total: total - beforeFee - bonusDriver,
            netProfit: bonusDriverGross - bonusDriver,
            bonusDriver: bonusDriver,
          })
        })
    }
  }, [data?.user.token, type])

  console.log(trx)
  return (
    <>
      <div className={'flex flex-row gap-2 items-center'}>
        <div className={'flex-1'}>
          <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
            Finance
          </h2>
        </div>
        <div>
          <div className={'dropdown dropdown-end'}>
            <div
              tabIndex={0}
              role={'button'}
              className={'btn btn-outline btn-md'}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
                className="w-4 h-4"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M6 13.5V3.75m0 9.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 3.75V16.5m12-3V3.75m0 9.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 3.75V16.5m-6-9V3.75m0 3.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 9.75V10.5"
                />
              </svg>
              Filter
            </div>
            <ul
              tabIndex={0}
              className={
                'dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52'
              }
            >
              <li onClick={() => setType('month')}>
                <a>Month</a>
              </li>
              <li onClick={() => setType('week')}>
                <a>Week</a>
              </li>
              <li onClick={() => setType('day')}>
                <a>Day</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <section className={'grid grid-cols-2 lg:grid-cols-4 gap-4'}>
        <div
          className={
            'stats stats-vertical shadow-sm border border-gray-200 border-solid'
          }
        >
          <div className="stat">
            <div className={'stat-title'}>Gross Profit </div>
            <div className={'stat-value text-2xl'}>
              {Number(trx?.beforeFee).toLocaleString('id-Id', {
                style: 'currency',
                currency: 'IDR',
              })}
            </div>
            <div className={'stat-desc'}>total balance in month</div>
          </div>
        </div>
        <div
          className={
            'stats stats-vertical shadow-sm border border-gray-200 border-solid'
          }
        >
          <div className="stat">
            <div className={'stat-title'}>Gross Profit 5%</div>
            <div className={'stat-value text-2xl'}>
              {Number(trx?.bonusDriver).toLocaleString('id-Id', {
                style: 'currency',
                currency: 'IDR',
              })}
            </div>
            <div className={'stat-desc'}>total bonus driver in month</div>
          </div>
        </div>

        <div
          className={
            'stats stats-vertical shadow-sm border border-gray-200 border-solid'
          }
        >
          <div className="stat">
            <div className={'stat-title'}>Gross Profit 15%</div>
            <div className={'stat-value text-2xl'}>
              {Number(trx?.netProfit).toLocaleString('id-Id', {
                style: 'currency',
                currency: 'IDR',
              })}
            </div>
            <div className={'stat-desc'}>income from driver</div>
          </div>
        </div>
        <div
          className={
            'stats stats-vertical shadow-sm border border-gray-200 border-solid'
          }
        >
          <div className="stat">
            <div className={'stat-title'}>Total Net Profit</div>
            <div className={'stat-value text-2xl'}>
              {Number(trx?.total).toLocaleString('id-Id', {
                style: 'currency',
                currency: 'IDR',
              })}
            </div>
            <div className={'stat-desc'}>total net profit in month</div>
          </div>
        </div>
      </section>
    </>
  )
}
