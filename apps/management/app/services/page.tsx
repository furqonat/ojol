import { Metadata } from 'next'
import { Services } from './service'

export const metadata: Metadata = {
  title: 'Lugo | Management Services',
}
export default function ServicesPage() {
  return (
    <main className={'container mx-auto px-4 md:px-0 py-6'}>
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Lugo Services
            </h2>
          </div>
        </div>
        <Services />
      </section>
    </main>
  )
}
