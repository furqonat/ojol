import { Metadata } from 'next'
import { Services } from './service'

export const metadata: Metadata = {
  title: 'Lugo | Management Services',
}
export default function ServicesPage() {
  return (
    <main>
      <Services />
    </main>
  )
}
