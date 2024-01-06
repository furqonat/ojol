'use client'

import { useState } from 'react'
import { Driver } from './driver.client'
import { Filter } from './filter.client'
import { Stats } from './stats.client'

export function Wrapper() {
  const [filter, setFilter] = useState<'day' | 'month' | 'year' | ''>('')
  return (
    <section className={'flex flex-col gap-5'}>
      <Filter onChange={setFilter} />
      <Stats filter={filter} />
      <Driver />
    </section>
  )
}
