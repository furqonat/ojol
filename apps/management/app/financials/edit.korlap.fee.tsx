'use client'

import { korlap_fee } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useRef, useState } from 'react'
import Select, { SingleValue } from 'react-select'

const accountType = ['KORLAP', 'KORCAP']
const accountOptions = accountType.map((item) => {
  return {
    label: item,
    value: item,
  }
})

type Option = {
  label: string
  value: string
}
export function EditKorlapFee(props: { data: korlap_fee }) {
  const { data } = useSession()

  const dialogRef = useRef<HTMLDialogElement>(null)

  const [amount, setAmount] = useState(0)
  const [accountType, setAccountType] = useState<SingleValue<Option> | null>({
    value: props.data.admin_type,
    label: props.data.admin_type,
  })
  const [loading, setLoading] = useState(false)

  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  async function handleCreateKorlapFee(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    const body: Partial<korlap_fee> = {
      percentage: amount,
    }
    const url =
      process.env.NEXT_PUBLIC_GATE_BASE_URL + `portal/korlap/${props.data.id}`
    const resp = await fetch(url, {
      method: 'PUT',
      body: JSON.stringify(body),
      headers: {
        Authorization: `Bearer ${data?.user.token}`,
        'Content-Type': 'application/json',
      },
    })
    if (resp.ok) {
      window.location.reload()
    }
  }

  function handleChangeAmount(e: React.ChangeEvent<HTMLInputElement>) {
    const { valueAsNumber } = e.target
    setAmount(valueAsNumber)
  }

  return (
    <>
      <button className={'btn btn-outline btn-sm'} onClick={handleOpenModal}>
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
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add new Korlap & Korcap fee</h3>
          <form onSubmit={handleCreateKorlapFee}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Account Type</span>
              </div>
              <Select
                isDisabled={true}
                value={accountType}
                options={accountOptions}
                onChange={(e) => setAccountType(e)}
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Amount In Percent</span>
              </div>
              <input
                value={amount}
                onChange={handleChangeAmount}
                required={true}
                type={'number'}
                placeholder="Amount"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <div className={'flex flex-row-reverse mt-4 gap-5'}>
              <button className={'btn btn-sm btn-primary'}>
                {loading ? <span className={'loading loading-dots'} /> : null}
                OK
              </button>
              <button
                type="button"
                className={'btn btn-sm'}
                onClick={handleCloseModal}
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
        <form method="dialog" className="modal-backdrop">
          <button>close</button>
        </form>
      </dialog>
    </>
  )
}
