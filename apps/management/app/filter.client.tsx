'use client'

import { useState } from 'react'

type FilterProps = {
  onChange?: (value: '' | 'day' | 'month' | 'year') => void
}

export function Filter(props: FilterProps) {
  const [filter, setFilter] = useState('')

  function handleChangeFilter(e: '' | 'day' | 'month' | 'year') {
    props.onChange && props.onChange(e)
    setFilter(e)
  }
  return (
    <div className={'flex flex-row gap-2 items-center'}>
      <div className={'flex-1'}>
        <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
          Dashboard
        </h2>
      </div>
      <div>
        <div className={'dropdown dropdown-end'}>
          <div
            tabIndex={0}
            role={'button'}
            className={'btn btn-outline btn-md capitalize'}
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
            {filter === '' ? 'Filter' : filter}
          </div>
          <ul
            tabIndex={0}
            className={
              'dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52'
            }
          >
            <li onClick={() => handleChangeFilter('')}>
              <a>All time</a>
            </li>
            <li onClick={() => handleChangeFilter('year')}>
              <a>Year</a>
            </li>
            <li onClick={() => handleChangeFilter('month')}>
              <a>Month</a>
            </li>
            <li onClick={() => handleChangeFilter('day')}>
              <a>Day</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  )
}
