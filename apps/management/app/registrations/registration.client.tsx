/* eslint-disable @next/next/no-img-element */
'use client'

import { UrlService } from '../../services/url.service'
import {
  Prisma,
  driver,
  driver_details,
  images,
  merchant,
  merchant_details,
  vehicle,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'

interface MerchantDetail extends merchant_details {
  images: images[]
}
interface Merchant extends merchant {
  details?: MerchantDetail
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
          className="tab col-span-1"
          aria-label="Merchants"
          defaultChecked
        />
        <div role="tabpanel" className="tab-content ">
          <div className={'flex flex-col gap-6'}>
            {registrations?.data.merchant?.map((item) => {
              if (item.details) {
                return (
                  <div key={item.id} className={'card rounded-sm shadow-sm'}>
                    <div className={'card-body flex-row'}>
                      <div className={'flex-1'}>
                        <h3 className={'card-title'}>{item.name}</h3>
                        <div className={'flex gap-4 items-center'}>
                          <span>{item?.email}</span>
                          <span className={'badge badge-primary'}>
                            {item.type}
                          </span>
                        </div>
                      </div>
                      <div>
                        <DetailMerchant data={item} />
                      </div>
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
          className="tab col-span-1"
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
  const { data: session } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)

  const url = new UrlService(
    `${process.env.NEXT_PUBLIC_PROD_BASE_URL}account/admin/driver/${data.id}`,
  )
  function handleOpenDialog(e: React.MouseEvent<HTMLButtonElement>) {
    e.preventDefault()
    dialogRef.current?.showModal()
  }

  function handleAcceptDriver(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const body: Prisma.driverUpdateInput = {
      status: 'ACTIVE',
    }
    fetch(url.build(), {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${session?.user.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then(() => dialogRef.current?.close())
  }

  function handleRejectDriver(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const body: Prisma.driverUpdateInput = {
      status: 'REJECT',
    }
    fetch(url.build(), {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${session?.user.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then(() => dialogRef.current?.close())
  }

  return (
    <>
      <button className={'btn'} onClick={handleOpenDialog}>
        Details
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box hide-scrollbar">
          <h3 className="font-bold text-lg">Driver Details</h3>
          <div className={'flex flex-col mt-6'}>
            {/*  */}
            <div className={'flex flex-col gap-6'}>
              <h4 className={'font-semibold mb-[-20px]'}>Driver Information</h4>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Name</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data.name ?? ''}
                  readOnly={true}
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
                  defaultValue={data.driver_details?.address}
                  readOnly={true}
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
                  defaultValue={data.phone ?? ''}
                  readOnly={true}
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
                  defaultValue={data.email ?? ''}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">ID Card Image</span>
                </div>
                <img
                  src={data.driver_details?.id_card_image ?? ''}
                  className={'rounded-md'}
                  alt={'id card image'}
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">License Image</span>
                </div>
                <img
                  src={data.driver_details?.license_image ?? ''}
                  className={'rounded-md'}
                  alt={'id card image'}
                />
              </label>
              <h4 className={'font-semibold mb-[-20px]'}>
                Vehicle Information
              </h4>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Vehicle Brand</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={
                    data.driver_details?.vehicle.vehicle_brand ?? ''
                  }
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Vehicle Type</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data.driver_details?.vehicle.vehicle_type ?? ''}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Vehicle Year</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data.driver_details?.vehicle.vehicle_year ?? ''}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">
                    Vehicle Registration Number
                  </span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data.driver_details?.vehicle.vehicle_rn ?? ''}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Vehicle Image</span>
                </div>
                <img
                  src={data.driver_details?.vehicle.vehicle_image ?? ''}
                  className={'rounded-md'}
                  alt={'id card image'}
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Vehicle Registration</span>
                </div>
                <img
                  src={data.driver_details?.vehicle.vehicle_registration ?? ''}
                  className={'rounded-md'}
                  alt={'id card image'}
                />
              </label>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex gap-6'}>
              <div className={'btn btn-primary'} onClick={handleAcceptDriver}>
                Accept
              </div>
              <div className={'btn btn-error'} onClick={handleRejectDriver}>
                Reject
              </div>
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}

function DetailMerchant(props: { data: Merchant }) {
  const { data } = props
  const { data: session } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)

  const url = new UrlService(
    `${process.env.NEXT_PUBLIC_PROD_BASE_URL}account/admin/merchant/${data.id}`,
  )
  function handleOpenDialog(e: React.MouseEvent<HTMLButtonElement>) {
    e.preventDefault()
    dialogRef.current?.showModal()
  }

  function handleAcceptMerchant(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const body: Prisma.merchantUpdateInput = {
      status: 'ACTIVE',
    }
    fetch(url.build(), {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${session?.user.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then(() => dialogRef.current?.close())
  }

  function handleRejectMerchant(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const body: Prisma.merchantUpdateInput = {
      status: 'REJECT',
    }
    fetch(url.build(), {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${session?.user.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then(() => dialogRef.current?.close())
  }

  return (
    <>
      <button className={'btn'} onClick={handleOpenDialog}>
        Details
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box hide-scrollbar">
          <h3 className="font-bold text-lg">Merchant Details</h3>
          <div className={'flex flex-col mt-6'}>
            {/*  */}
            <div className={'flex flex-col gap-6'}>
              <h4 className={'font-semibold mb-[-20px]'}>Owner Information</h4>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Name</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data.name ?? ''}
                  readOnly={true}
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
                  defaultValue={data.phone ?? ''}
                  readOnly={true}
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
                  defaultValue={data.email ?? ''}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">ID Card Image</span>
                </div>
                <img
                  src={data.details?.id_card_image ?? ''}
                  className={'rounded-md'}
                  alt={'id card image'}
                />
              </label>
              <h4 className={'font-semibold mb-[-20px]'}>Shop Information</h4>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Shop Name</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data.details?.name ?? ''}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Shop Address</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={data?.details?.address}
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Shop Images</span>
                </div>
                <div className={'flex flex-col gap-4'}>
                  {data.details?.images?.map((item) => {
                    return (
                      <img
                        className={'rounded-md'}
                        key={item.id}
                        alt={'image shop'}
                        src={item.link}
                      />
                    )
                  })}
                </div>
              </label>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex gap-6'}>
              <div className={'btn btn-primary'} onClick={handleAcceptMerchant}>
                Accept
              </div>
              <div className={'btn btn-error'} onClick={handleRejectMerchant}>
                Reject
              </div>
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
