import { Metadata } from 'next'
import { Bonus } from './bonus.client'

export const metadata: Metadata = {
  title: 'Bonus drivers | Lugo management',
  description: 'This website for admin management lugo application',
}

export default function BonusPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Bonus Drivers
            </h2>
          </div>
          <div></div>
        </div>
        <Bonus />
      </section>
    </main>
  )
}
