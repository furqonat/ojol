'use client'

import { useState } from 'react'
import { Driver } from './driver.client'
import { Filter } from './filter.client'
import { Stats } from './stats.client'
import { useSession } from 'next-auth/react'
import { isSuperAdmin } from '../services'
import { Finance } from './korlap/finance'

export function Wrapper() {
  const { data } = useSession()
  const [filter, setFilter] = useState<'day' | 'month' | 'year' | ''>('')
  return (
    <>
      {isSuperAdmin(data) ? (
        <section className={'flex flex-col gap-5'}>
          <Filter onChange={setFilter} />
          <Stats filter={filter} />
          <Driver />
        </section>
      ) : (
        <Finance />
      )}
    </>
  )
}
