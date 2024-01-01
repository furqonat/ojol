'use client'

import { Prisma, settings } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'

export function Settings() {
  const { data } = useSession()
  const [settings, setSettings] = useState<settings[]>([])

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_PROD_BASE_URL + 'gate/portal/settings'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setSettings)
    }
  }, [data?.user?.token])
  return (
    <section>
      <div className={'flex flex-col gap-6'}>
        {settings?.map((item) => {
          return (
            <div className={'card shadow-md '} key={item.id}>
              <div className={'card-body'}>
                <div className={'flex w-full'}>
                  <h3 className={'card-title flex-1'}>{item.slug}</h3>
                  <Actions data={item} />
                </div>
              </div>
            </div>
          )
        })}
      </div>
    </section>
  )
}

function Actions(props: { data: settings }) {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)
  const [phone, setPhone] = useState(props.data?.phone)
  const [email, setEmail] = useState(props.data?.email)
  const [sk, setSk] = useState(props.data?.sk ?? '')

  function handleChangePhone(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setPhone(value)
  }
  function handleChangeEmail(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setEmail(value)
  }
  function handleChangeSk(e: React.ChangeEvent<HTMLTextAreaElement>) {
    const { value } = e.target
    setSk(value)
  }

  function handleOnSave(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const url =
      process.env.NEXT_PUBLIC_PROD_BASE_URL +
      `gate/portal/settings/${props.data.id}`
    const body: Prisma.settingsUpdateInput = {
      sk: sk,
      phone: phone,
      email: email,
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

  return (
    <>
      <button
        className="btn btn-sm btn-ghost"
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
          <h3 className="font-bold text-lg">Update SK</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex flex-col gap-6 mt-6 items-center'}>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Company Phone Number</span>
                </div>
                <input
                  type="text"
                  value={phone}
                  onChange={handleChangePhone}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Company Email</span>
                </div>
                <input
                  type="text"
                  value={email}
                  onChange={handleChangeEmail}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Privacy Policy</span>
                </div>
                <textarea
                  value={sk}
                  onChange={handleChangeSk}
                  placeholder="SK"
                  className={'textarea textarea-bordered'}
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
