'use client'

import { banner } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useState } from 'react'

export function Promotion() {
  const [banners, setBanners] = useState<banner[]>([])
  const { data } = useSession()

  useEffect(() => {
    if (data?.user.token) {
      const url = process.env.NEXT_PUBLIC_PROD_BASE_URL + 'gate/portal/banner'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setBanners)
    }
  }, [data?.user.token])

  console.log(banners)
  return (
    <section>
      <div></div>
    </section>
  )
}
