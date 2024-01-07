'use client'

import { useSession } from 'next-auth/react'
import { useRef, useState } from 'react'
import Select, { SingleValue } from 'react-select'

export const serviceTypes = ['BIKE', 'CAR', 'MART', 'FOOD', 'DELIVERY']
export const accountTypes = ['BASIC', 'REGULAR', 'PREMIUM']

const servicesOptions = serviceTypes.map((item) => {
  return {
    label: item,
    value: item,
  }
})
const accountOptions = accountTypes.map((item) => {
  return {
    label: item,
    value: item,
  }
})

type Option = {
  label: string
  value: string
}
export function AddNewServiceFee() {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)

  const [serviceType, setServiceType] = useState<SingleValue<Option> | null>(
    null,
  )
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

  async function handleCreateServiceFee(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/fee'
    const body = {
      service_type: serviceType?.value,
      account_type: accountType?.value,
      percentage: amount,
    }
    const resp = await fetch(url, {
      method: 'POST',
      body: JSON.stringify(body),
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
      },
    })

    if (resp.ok) {
      dialogRef.current?.close()
      window.location.reload()
    }
  }

  return (
    <div>
      <button className={'btn btn-outline btn-sm'} onClick={handleOpenModal}>
        Add New
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add new service fee</h3>
          <form onSubmit={handleCreateServiceFee}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Service Type</span>
              </div>
              <Select
                value={serviceType}
                options={servicesOptions}
                onChange={(e) => setServiceType(e)}
              />
            </label>
            {serviceType?.value === 'MART' || serviceType?.value === 'FOOD' ? (
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
            ) : null}
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
    </div>
  )
}
