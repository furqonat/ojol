import { Metadata } from 'next'
import { Registration } from './registration.client'

export const metadata: Metadata = {
  title: 'Lugo | Registration',
  description: 'A collection of registration driver and merchant',
}
export default async function RegistrationsPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Registrations
            </h2>
          </div>
          <div></div>
        </div>
        <Registration />
      </section>
    </main>
  )
}
