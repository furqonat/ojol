import { NextRequest } from 'next/server'

export async function POST(req: NextRequest) {
  const { authCode, state } = await req.json()

  const resp = await fetch(
    `https://api.gentatechnology.com/gate/oauth/?customerId=${state}`,
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
