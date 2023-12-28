'use client'

import { services } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'

export function Services() {
  const [services, setServices] = useState<services[]>([])
  const { data } = useSession()
  useEffect(() => {
    if (data?.user?.token) {
      fetch(`${process.env.NEXT_PUBLIC_PROD_BASE_URL}gate/services/all`, {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
          'Access-Control-Allow-Origin': '*',
          'Content-type': 'application/json',
        },
      })
        .then((res) => res.json())
        .then(setServices)
        .catch()
    }
  }, [data?.user.token])

  console.log(services)

  return (
    <section>
      <div></div>
    </section>
  )
}
