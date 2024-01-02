'use client'

import { Prisma, banner } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'
import Select from 'react-select'

export function Promotion() {
  const [banners, setBanners] = useState<banner[]>([])
  const { data } = useSession()

  useEffect(() => {
    if (data?.user.token) {
      const url = process.env.NEXT_PUBLIC_PROD_BASE_URL + 'gate/portal/banner'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setBanners)
    }
  }, [data?.user.token])

  return (
    <section className={'flex flex-col gap-6'}>
      {banners?.map((item) => {
        return (
          <div key={item.id} className={'card shadow-md'}>
            <div className={'card-body'}>
              <div className={'flex w-full'}>
                <h3 className={'card-title flex-1'}>
                  {item.for_app
                    ? `Customer App Banner | ${item.position}`
                    : 'Merchant App Banner'}
                </h3>
                <UpdateBanner data={item} />
              </div>
            </div>
          </div>
        )
      })}
    </section>
  )
}

function UpdateBanner(props: { data: banner }) {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)
  const [status, setStatus] = useState(false)
  const [position, setPosition] = useState<'TOP' | 'BOTTOM'>(
    props.data.position,
  )

  function handleOnSave(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const url = process.env.NEXT_PUBLIC_PROD_BASE_URL + `gate/portal/banner`
    const body: Prisma.bannerCreateInput = {
      position: position,
      for_app: status,
    }
    fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      dialogRef.current?.close()
    })
  }

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
  }

  return (
    <>
      <button
        className="btn btn-sm btn-outline"
        onClick={() => dialogRef.current?.showModal()}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth={1.5}
          stroke="currentColor"
          className="w-4 h-4"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L6.832 19.82a4.5 4.5 0 0 1-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 0 1 1.13-1.897L16.863 4.487Zm0 0L19.5 7.125"
          />
        </svg>
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <h3 className="font-bold text-lg">Update Banner</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex flex-col gap-6 mt-6 items-center'}>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Position</span>
                </div>
                <Select
                  value={position}
                  options={['BOTTOM', 'TOP']}
                  onChange={(e) => setPosition(e as 'TOP' | 'BOTTOM')}
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">For Customer App</span>
                </div>
                <input
                  type="checkbox"
                  className="toggle"
                  checked={status}
                  onChange={handleChangeToggle}
                />
              </label>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog">
              <div className="btn btn-primary" onClick={handleOnSave}>
                Save
              </div>
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
