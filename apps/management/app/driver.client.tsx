/* eslint-disable @next/next/no-img-element */
'use client'

import { useSession } from 'next-auth/react'
import { useCallback, useEffect, useRef, useState } from 'react'
import { UrlService } from '../services'
import {
  driver,
  driver_details,
  driver_wallet,
  vehicle,
} from '@prisma/client/users'
interface Details extends driver_details {
  vehicle: vehicle
}
interface Driver extends driver {
  driver_details: Details
  driver_wallet: driver_wallet
  _count: {
    order: number
  }
}
type Response = {
  data: Driver[]
  total: number
}

export function Driver() {
  const { data } = useSession()
  const [drivers, setDrivers] = useState<Response | null>(null)
  const fetchDriver = useCallback(async () => {
    if (data?.user.token) {
      const url = new UrlService(
        `${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/driver`,
      )
        .addQuery('id', 'true')
        .addQuery('name', 'true')
        .addQuery('driver_details', '{include: {vehicle: true}}')
        .addQuery('driver_wallet', 'true')
        .addQuery('orderBy', 'order')
        .addQuery('avatar', 'true')
        .addQuery('_count', 'true')
        .addQuery('type', 'ACTIVE')
      fetch(url.build(), {
        headers: {
          Authorization: `Bearer ${data.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setDrivers)
    }
  }, [data?.user.token])

  useEffect(() => {
    fetchDriver().then()
  }, [fetchDriver])
  console.log(drivers)

  return (
    <section>
      <section className={'mt-5'}>
        <h2 className={'text-lg md:text-xl lg:text-2xl font-semibold'}>
          Top Driver
        </h2>
      </section>
      <section>
        <div className="overflow-x-auto">
          <table className="table">
            {/* head */}
            <thead>
              <tr>
                <th>No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Total Jobs</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {/* row 1 */}
              {drivers &&
                drivers?.data?.map((item, index) => {
                  return (
                    <tr key={item.id}>
                      <th>{index + 1}</th>
                      <td>
                        <div className="flex items-center gap-3">
                          <div className="avatar">
                            <div className="mask mask-squircle w-12 h-12">
                              <img
                                src={item.avatar ?? '/lugo.png'}
                                alt="Avatar Tailwind CSS Component"
                              />
                            </div>
                          </div>
                          <div>
                            <div className="font-bold">{item?.name}</div>
                            <div className="text-sm opacity-50">
                              {item.driver_details?.badge}
                            </div>
                          </div>
                        </div>
                      </td>
                      <td>
                        {item.driver_details?.address}
                        <br />
                        <span className="badge badge-ghost badge-sm capitalize">
                          {item.driver_details?.driver_type.toLowerCase()}{' '}
                          Driver
                        </span>
                      </td>
                      <td>{item._count?.order}</td>
                      <th>
                        <DriverDetails data={item} />
                      </th>
                    </tr>
                  )
                })}
            </tbody>
          </table>
        </div>
      </section>
    </section>
  )
}

function DriverDetails(props: { data: Driver }) {
  const { data } = props
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleOpenDialog(e: React.MouseEvent<HTMLButtonElement>) {
    e.preventDefault()
    dialogRef.current?.showModal()
  }

  return (
    <>
      <button className={'btn btn-outline'} onClick={handleOpenDialog}>
        Details
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box hide-scrollbar">
          <h3 className="font-bold text-lg">Driver Details</h3>
          <div className={'flex flex-col mt-6'}>
            {/*  */}
            <div className={'flex flex-col gap-6'}>
              <h4 className={'font-semibold mb-[-20px]'}>Driver Wallet</h4>

              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Ballance</span>
                </div>
                <input
                  required={true}
                  type="text"
                  defaultValue={
                    Number(data.driver_wallet?.balance)?.toLocaleString(
                      'id-ID',
                      {
                        currency: 'IDR',
                        style: 'currency',
                      },
                    ) ?? '0'
                  }
                  readOnly={true}
                  placeholder="Admin Name"
                  className="input input-bordered w-full input-sm"
                />
              </label>
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
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
