import Image from 'next/image'

export default async function OAuthSuccessPage() {
  return (
    <main className={'container mx-auto min-h-screen px-6'}>
      <div
        className={
          'flex flex-col items-center justify-center align-middle min-h-screen gap-10'
        }
      >
        <Image
          src={'/success.png'}
          width={300}
          height={300}
          alt={'success image'}
        />
        <h3 className={'font-semibold text-2xl text-center'}>
          Berhasil menghubungkan akun dana ke Lugo
        </h3>
      </div>
    </main>
  )
}
