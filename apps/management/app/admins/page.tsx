import { Metadata } from 'next'
import { AddAdmin } from './add.admin'
import { Admin } from './admin'

export const metadata: Metadata = {
  title: 'Admin | Lugo management',
}

export default function AdminPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Admin
            </h2>
          </div>
          <AddAdmin />
        </div>
        <div className={'flex flex-col'}>
          <Admin />
        </div>
      </section>
    </main>
  )
}
