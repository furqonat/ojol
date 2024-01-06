'use client'

import { useEffect, useRef, useState } from 'react'
import { AddNewServiceFee, accountTypes, serviceTypes } from './add.service.fee'
import { service_fee } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import Select, { SingleValue } from 'react-select'

type Response = {
  data: service_fee[]
}

export function ServiceFee() {
  const { data } = useSession()
  const [serviceFee, setServiceFee] = useState<Response | null>(null)

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/fee'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setServiceFee)
    }
  }, [data?.user?.token])

  console.log(serviceFee)
  return (
    <section>
      <div className={'flex w-full items-center'}>
        <h2 className={'text-xl font-semibold flex-1'}>Service Fee</h2>
        <AddNewServiceFee />
      </div>
      <div className={'flex flex-col gap-6'}>
        {serviceFee?.data?.map((item) => {
          return (
            <div key={item.id} className={'card shadow-md'}>
              <div className={'card-body'}>
                <div className={'flex flex-row w-full'}>
                  <div className={'flex-1'}>
                    <h3 className={'card-title capitalize'}>
                      {item.service_type.toLowerCase()}
                    </h3>
                    <div className={'flex gap-2 items-center'}>
                      <span className={'badge'}>{item.account_type}</span>
                      <span>{item.percentage} %</span>
                    </div>
                  </div>
                  <EditServiceFee data={item} />
                </div>
              </div>
            </div>
          )
        })}
      </div>
    </section>
  )
}

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

function EditServiceFee(props: { data: service_fee }) {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)

  const [serviceType, setServiceType] = useState<SingleValue<Option>>({
    value: props.data.service_type,
    label: props.data.service_type,
  })
  const [accountType, setAccountType] = useState<SingleValue<Option>>({
    value: props.data.account_type,
    label: props.data.account_type,
  })
  const [amount, setAmount] = useState(props.data.percentage)
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
    const url =
      process.env.NEXT_PUBLIC_GATE_BASE_URL + `gate/portal/fee/${props.data.id}`
    const body = {
      service_type: serviceType?.value,
      account_type: accountType?.value,
      percentage: amount,
    }
    const resp = await fetch(url, {
      method: 'PUT',
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
    </div>
  )
}
