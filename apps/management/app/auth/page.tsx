import Image from 'next/image'
import { Form } from './form.client'

export default async function SignIn() {
  return (
    <main className={'container min-h-screen'}>
      <div
        className={
          'grid grid-cols-1 lg:grid-cols-2 gap-6 items-center justify-center min-h-screen'
        }
      >
        <section
          className={'flex flex-col items-center justify-center text-center'}
        >
          <Image
            src={'/auth-welcome.svg'}
            width={400}
            height={400}
            alt={'welcome assets'}
          />
          <h3 className={'text-2xl'}>Welcome to Lugo Management System</h3>
          <p>To continue please fill the credentials</p>
        </section>
        <section className={'flex flex-col items-center justify-center'}>
          <div className={'card p-5 card-bordered'}>
            <div className={'card-body'}>
              <Form />
            </div>
          </div>
        </section>
      </div>
    </main>
  )
}
