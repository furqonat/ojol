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
export function AddKorlapFee() {
  const { data } = useSession()

  const dialogRef = useRef<HTMLDialogElement>(null)

  const [amount, setAmount] = useState(0)
  const [accountType, setAccountType] = useState<SingleValue<Option> | null>(
    null,
  )
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
      admin_type: accountType?.value as 'KORLAP' | 'KORCAP',
    }
    const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/korlap'
    const resp = await fetch(url, {
      method: 'POST',
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
        Add New
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
