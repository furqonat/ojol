import { Merchants } from './merchants.client'

export default function MerchantsPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Merchants
            </h2>
          </div>
          <div></div>
        </div>
        <Merchants />
      </section>
    </main>
  )
}
