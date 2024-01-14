import { NextRequest } from 'next/server'

export async function POST(req: NextRequest) {
  const { authCode, state } = await req.json()
  if ((state as string).startsWith('merch')) {
    const [, merchantId] = (state as string).split('-')
    const resp = await fetch(
      `https://gate.gentatechnology.com/oauth/merchant?customerId=${merchantId}`,
      {
        method: 'POST',
        body: JSON.stringify({ access_token: authCode }),
      },
    )
    if (!resp.ok) {
      throw new Error('Unable apply token')
    }
    return await resp.json()
  }
  if ((state as string).startsWith('dri')) {
    const [, driverId] = (state as string).split('-')
    const resp = await fetch(
      `https://gate.gentatechnology.com/oauth/driver?customerId=${driverId}`,
      {
        method: 'POST',
        body: JSON.stringify({ access_token: authCode }),
      },
    )
    if (!resp.ok) {
      throw new Error('Unable apply token')
    }
    return await resp.json()
  }
  const resp = await fetch(
    `https://gate.gentatechnology.com/oauth/?customerId=${state}`,
    {
      method: 'POST',
      body: JSON.stringify({ access_token: authCode }),
    },
  )
  if (!resp.ok) {
    throw new Error('Unable apply token')
  }
  return await resp.json()
}
