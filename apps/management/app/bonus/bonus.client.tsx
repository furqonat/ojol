'use client'

import {
  bonus_driver,
  driver,
  driver_details,
  driver_wallet,
  order,
  vehicle,
} from '@prisma/client/users'
import { UrlService } from '../../services/url.service'
import { useSession } from 'next-auth/react'
import { useEffect, useRef, useState } from 'react'

interface Details extends driver_details {
  vehicle: vehicle
}
type BonusDriver = bonus_driver & {
  order: order
}

type Driver = driver & {
  bonus_driver: BonusDriver[]
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

export function Bonus() {
  const { data } = useSession()
  const [drivers, setDrivers] = useState<Response | null>(null)

  useEffect(() => {
    if (data?.user?.token) {
      const url = process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL + '/admin/driver'
      const builder = new UrlService(url)
        .addQuery('id', 'true')
        .addQuery('avatar', 'true')
        .addQuery('driver_details', '{include: {vehicle: true}}')
        .addQuery('driver_wallet', 'true')
        .addQuery('_count', 'true')
        .addQuery('orderBy', 'order')
        .addQuery(
          'bonus_driver',
          '{include: {order:{include: {customer: true, order_items: {include: {product: true}}}}}}',
        )
      fetch(builder.build(), {
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setDrivers)
    }
  }, [data?.user?.token])

  console.log(drivers)

  return (
    <section>
      <div className="overflow-x-auto">
        <table className="table">
          {/* head */}
          <thead>
            <tr>
              <th>No</th>
              <th>Name</th>
              <th>Address</th>
              <th>Total Bonus</th>
              <th>Details</th>
              <th>Action</th>
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
                            {/* eslint-disable-next-line @next/next/no-img-element */}
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
                        {item.driver_details?.driver_type.toLowerCase()} Driver
                      </span>
                    </td>
                    <td>
                      {Number(
                        item.bonus_driver?.reduce((a, b) => a + b.amount, 0),
                      )?.toLocaleString('id-ID', {
                        style: 'currency',
                        currency: 'IDR',
                      })}
                    </td>
                    <th>
                      <div className={'flex gap-3'}>
                        <DriverDetails data={item} />
                        <DriverBonus data={item.bonus_driver} />
                      </div>
                    </th>
                  </tr>
                )
              })}
          </tbody>
        </table>
      </div>
    </section>
  )
}

function DriverBonus(props: { data: BonusDriver[] }) {
  const { data } = props
  const dialogRef = useRef<HTMLDialogElement>(null)
  return (
    <>
      <button
        className={'btn btn-outline btn-sm'}
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
            d="M12 3.75v16.5M2.25 12h19.5M6.375 17.25a4.875 4.875 0 0 0 4.875-4.875V12m6.375 5.25a4.875 4.875 0 0 1-4.875-4.875V12m-9 8.25h16.5a1.5 1.5 0 0 0 1.5-1.5V5.25a1.5 1.5 0 0 0-1.5-1.5H3.75a1.5 1.5 0 0 0-1.5 1.5v13.5a1.5 1.5 0 0 0 1.5 1.5Zm12.621-9.44c-1.409 1.41-4.242 1.061-4.242 1.061s-.349-2.833 1.06-4.242a2.25 2.25 0 0 1 3.182 3.182ZM10.773 7.63c1.409 1.409 1.06 4.242 1.06 4.242S9 12.22 7.592 10.811a2.25 2.25 0 1 1 3.182-3.182Z"
          />
        </svg>
      </button>

      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <h3 className="font-bold text-lg">List Bonus</h3>
          {/* <DriverDetails data={data?.order?.customer} /> */}
          <div className={'flex flex-col gap-4'}>
            {data?.map((item) => {
              return (
                <div className={'card shadow-sm'} key={item.id}>
                  <div className={'card-body'}>
                    <div className={'flex w-full items-center'}>
                      <div className={'flex-1'}>
                        <div className={'card-title'}>
                          {item.order.order_type}
                        </div>
                        <span>
                          {new Date(item.order.created_at).toLocaleString(
                            'in-ID',
                            {
                              year: 'numeric',
                              month: 'long',
                              day: 'numeric',
                              hour: 'numeric',
                              minute: 'numeric',
                              second: 'numeric',
                            },
                          )}
                        </span>
                      </div>
                      <div>
                        <span className="font-bold text-2xl">
                          {Number(item.amount).toLocaleString('id-ID', {
                            style: 'currency',
                            currency: 'IDR',
                          })}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              )
            })}
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

function DriverDetails(props: { data: Driver }) {
  const { data } = props
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleOpenDialog(e: React.MouseEvent<HTMLButtonElement>) {
    e.preventDefault()
    dialogRef.current?.showModal()
  }

  return (
    <>
      <button className={'btn btn-outline btn-sm'} onClick={handleOpenDialog}>
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
            d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 0 0 2.25-2.25V6.75A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25v10.5A2.25 2.25 0 0 0 4.5 19.5Zm6-10.125a1.875 1.875 0 1 1-3.75 0 1.875 1.875 0 0 1 3.75 0Zm1.294 6.336a6.721 6.721 0 0 1-3.17.789 6.721 6.721 0 0 1-3.168-.789 3.376 3.376 0 0 1 6.338 0Z"
          />
        </svg>
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box hide-scrollbar">
          <h3 className="font-bold text-lg">Driver Details</h3>
          <div className={'flex flex-col mt-6'}>
            {/* eslint-disable-next-line @next/next/no-img-element */}

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
                {/* eslint-disable-next-line @next/next/no-img-element */}
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
                {/* eslint-disable-next-line @next/next/no-img-element */}
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
                {/* eslint-disable-next-line @next/next/no-img-element */}
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
                {/* eslint-disable-next-line @next/next/no-img-element */}
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
