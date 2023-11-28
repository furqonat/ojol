import { Metadata } from 'next'
import { GoogleMap } from './google.map'

export const metadata: Metadata = {
  title: 'Lugo | Tracking realtime location',
  description: 'tracking driver car and bike realtime location',
}

export default function TrackingPage() {
  return (
    <main className={'flex h-full flex-col'}>
      <GoogleMap />
    </main>
  )
}
