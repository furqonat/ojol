'use client'

import { useSession } from 'next-auth/react'
import { useRef, useState } from 'react'
import Select, { SingleValue } from 'react-select'
import { appOptions, taxOptions } from './edit.tax'

type Option = {
  label: string
  value: string
}

export function AddTax() {
  const { data } = useSession()

  const dialogRef = useRef<HTMLDialogElement>(null)

  const [taxType, setTaxType] = useState<SingleValue<Option> | null>(null)
  const [accountType, setAccountType] = useState<SingleValue<Option> | null>(
    null,
  )
  const [amount, setAmount] = useState(0)
  const [loading, setLoading] = useState(false)

  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  function handleChangeAmount(e: React.ChangeEvent<HTMLInputElement>) {
    const { valueAsNumber } = e.target
    setAmount(valueAsNumber)
  }

  async function handleCreateKorlapFee(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    const body = {
      amount: amount,
      applied_for: accountType?.value,
      is_percent: true,
      tax_type: taxType?.value,
    }
    const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/tax'
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

  return (
    <>
      <button className={'btn btn-outline btn-sm'} onClick={handleOpenModal}>
        Add New
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add Tax PPH or PPN</h3>
          <form onSubmit={handleCreateKorlapFee}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Service Type</span>
              </div>
              <Select
                value={taxType}
                options={taxOptions}
                onChange={(e) => setTaxType(e)}
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Account Type</span>
              </div>
              <Select
                value={accountType}
                options={appOptions}
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
