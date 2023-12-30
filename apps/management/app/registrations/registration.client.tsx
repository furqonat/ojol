'use client'

import {
  driver,
  driver_details,
  merchant,
  merchant_details,
  vehicle,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'

interface Merchant extends merchant {
  details?: merchant_details
}

interface Details extends driver_details {
  vehicle: vehicle
}

interface Driver extends driver {
  driver_details?: Details
}

type RegistationData = {
  merchant: Merchant[]
  driver: Driver[]
}

type ResponseData = {
  data: RegistationData
  total: {
    merchant: number
    driver: number
  }
}

export function Registration() {
  const [registrations, setRegistrations] = useState<ResponseData | null>(null)
  const { data } = useSession()
  useEffect(() => {
    const url =
      process.env.NEXT_PUBLIC_PROD_BASE_URL + 'account/admin/registration'
    if (data?.user?.token) {
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setRegistrations)
    }
  }, [data?.user?.token])

  return (
    <section>
      <div role="tablist" className="tabs tabs-bordered w-full grid-cols-2">
        <input
          type="radio"
          name="my_tabs_2"
          role="tab"
          className="tab"
          aria-label="Merchants"
          checked
          onChange={() => {}}
        />
        <div role="tabpanel" className="tab-content ">
          <div className={'flex flex-col gap-6'}>
            {registrations?.data.merchant?.map((item) => {
              if (item.details) {
                return (
                  <div key={item.id} className={'card rounded-sm shadow-sm'}>
                    <div className={'card-body'}>
                      <h3 className={'card-title'}>{item.name}</h3>
                      <p>{item?.email}</p>
                    </div>
                  </div>
                )
              }
              return null
            })}
          </div>
        </div>

        <input
          type="radio"
          name="my_tabs_2"
          role="tab"
          className="tab"
          aria-label="Drivers"
        />
        <div role="tabpanel" className="tab-content">
          <div className={'flex flex-col gap-6'}>
            {registrations?.data.driver?.map((item) => {
              if (item.driver_details) {
                return (
                  <div key={item.id} className={'card rounded-sm shadow-sm'}>
                    <div className={'card-body flex-row'}>
                      <div className={'flex-1'}>
                        <h3 className={'card-title'}>{item.name}</h3>
                        <div className={'flex gap-4 items-center'}>
                          <span>{item?.email}</span>
                          <span className={'badge badge-primary'}>
                            {item.driver_details.driver_type}
                          </span>
                        </div>
                      </div>
                      <div>
                        <DetailDriver data={item} />
                      </div>
                    </div>
                  </div>
                )
              }
              return null
            })}
          </div>
        </div>
      </div>
    </section>
  )
}

function DetailDriver(props: { data: Driver }) {
  const { data } = props
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleOpenDialog(e: React.MouseEvent<HTMLButtonElement>) {
    e.preventDefault()
    dialogRef.current?.showModal()
  }

  function handleAcceptDriver(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
  }

  return (
    <>
      <button className={'btn'} onClick={handleOpenDialog}>
        Details
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box max-w-[calc(100vw - 10em)]">
          <h3 className="font-bold text-lg">Driver Details</h3>
          <div className={'flex flex-col'}>
            {/*  */}
            <div className={'flex flex-col gap-6'}>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Name</span>
                </div>
                <input
                  required={true}
                  type="text"
                  value={data.name ?? ''}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Address</span>
                </div>
                <input
                  required={true}
                  type="text"
                  value={data.driver_details?.address}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Phone Number</span>
                </div>
                <input
                  required={true}
                  type="text"
                  value={data.phone ?? ''}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Email</span>
                </div>
                <input
                  required={true}
                  type="text"
                  value={data.email ?? ''}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Referal</span>
                </div>
                <input
                  required={true}
                  type="text"
                  value={data.referal_id ?? ''}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex gap-6'}>
              <div className={'btn btn-primary'} onClick={handleAcceptDriver}>
                Accept
              </div>
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
