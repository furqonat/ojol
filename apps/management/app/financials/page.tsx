import { Discount } from './discount'
import { Finance } from './finance.client'
import { KorlapFee } from './korlap.fee'
import { ServiceFee } from './service.fee'
import { Tax } from './tax'

export default function FinancialPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      {/* Stats */}
      <section className={'flex flex-col gap-5'}>
        <Finance />
        <div className={'flex flex-col gap-7'}>
          <ServiceFee />
          <Discount />
          <KorlapFee />
          <Tax />
        </div>
      </section>
    </main>
  )
}
