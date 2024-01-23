'use client'

import {
  Prisma,
  customer,
  dana_token,
  driver,
  driver_details,
  driver_wallet,
  merchant,
  merchant_details,
  order,
  transactions,
  vehicle,
} from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useRef, useState } from 'react'
import Select, { SingleValue } from 'react-select'

const badge = ['BASIC', 'REGULAR', 'PREMIUM']

interface User extends customer {
  _count: {
    order: number
    dana_token: number
  }
  dana_token?: dana_token
}

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

interface Merchant extends merchant {
  _count: {
    products: number
  }
  products: {
    _count: {
      order_item: number
    }
  }
  details?: merchant_details
}

type Trx = transactions & {
  order: order
}

type SearchResult = {
  merchant: Merchant[]
  customer: User[]
  driver: Driver[]
  order: order[]
  transaction: Trx[]
}

export function SearchClient() {
  const { data } = useSession()
  const query = useSearchParams()
  const search = query.get('q')
  const router = useRouter()

  const [searchResult, setSearchResult] = useState<SearchResult | null>(null)

  useEffect(() => {
    if (search) {
      const url =
        process.env.NEXT_PUBLIC_GATE_BASE_URL + `/portal/search?q=${search}`
      fetch(url, {
        method: 'GET',
        headers: {
          Authorization: `Bearer ${data?.user?.token}`,
        },
      })
        .then((e) => e.json())
        .then(setSearchResult)
    } else {
      router.push('/')
    }
  }, [search, router, data?.user?.token])

  console.log(searchResult)
  return (
    <div role="tablist" className="tabs tabs-lifted">
      <input
        defaultChecked
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Transactions"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        {searchResult?.transaction?.map((item) => {
          return (
            <div
              className={'card w-full card-side shadow-sm items-center'}
              key={item.id}
            >
              <div className={'card-body'}>
                <h3 className={'card-title'}>{item.id}</h3>
                <span>{item.type}</span>
              </div>
              <div className={'card-actions'}>
                <ViewDetailTrx transaction={item} />
              </div>
            </div>
          )
        })}
      </div>

      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Customer"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        <div className="overflow-x-auto">
          <table className="table">
            {/* head */}
            <thead>
              <tr>
                <th>No</th>
                <th>Name</th>
                <th>Dana</th>
                <th>Total Order</th>
              </tr>
            </thead>
            <tbody>
              {/* row 1 */}
              {searchResult?.customer?.map((item, index) => {
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
                            {item?.status}
                          </div>
                        </div>
                      </div>
                    </td>
                    <td>
                      <span className="badge badge-ghost badge-sm capitalize">
                        {item?.dana_token ? (
                          <span>Connected</span>
                        ) : (
                          <span>Not Connected </span>
                        )}
                      </span>
                    </td>
                    <td>{item._count?.order}</td>
                    <td>
                      <Actions
                        checked={item.status === 'ACTIVE'}
                        id={item.id}
                      />
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      </div>
      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Merchant"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
        <div className="overflow-x-auto">
          <table className="table">
            {/* head */}
            <thead>
              <tr>
                <th>No</th>
                <th>Name</th>
                <th>Bage</th>
                <th>Total Product</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {/* row 1 */}
              {searchResult?.merchant?.map((item, index) => {
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
                            {item?.status}{' '}
                          </div>
                        </div>
                      </div>
                    </td>
                    <td>
                      <span className="badge badge-primary badge-sm capitalize">
                        {item?.details?.badge}
                      </span>
                    </td>
                    <td>{item._count?.products}</td>
                    <td className={'flex gap-6'}>
                      <ActionsMerchant data={item} />
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      </div>
      <input
        type="radio"
        name="my_tabs_2"
        role="tab"
        className="tab"
        aria-label="Driver"
      />
      <div
        role="tabpanel"
        className="tab-content bg-base-100 border-base-300 rounded-box p-6"
      >
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
                {searchResult?.driver?.map((item, index) => {
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
      </div>
    </div>
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

function Actions(props: { checked: boolean; id: string }) {
  const { data } = useSession()
  const [status, setStatus] = useState(props.checked)
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
    const url =
      process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL + `admin/customer/${props.id}`
    const body: Prisma.customerUpdateInput = {
      status: checked === true ? 'ACTIVE' : 'BLOCK',
    }
    fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      if (e.ok) {
        setStatus(true)
        window.location.reload()
      } else {
        setStatus(false)
      }
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
          <h3 className="font-bold text-lg">Update Users</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex gap-6 mt-6 items-center'}>
              <h4 className={'font-semibold flex-1'}>Status User</h4>
              <input
                type="checkbox"
                className="toggle"
                checked={status}
                onChange={handleChangeToggle}
              />
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}

function ViewDetailTrx(props: { transaction: Trx }) {
  const dialogRef = useRef<HTMLDialogElement>(null)
  const { transaction: trx } = props
  return (
    <>
      <button className={'btn'} onClick={() => dialogRef.current?.showModal()}>
        View
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <div key={trx.id} className={'card shadow-md'}>
            <figure className={'max-h-[200px]'}>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                height={200}
                src={`https://placehold.co/800?text=TRX+${trx.order.order_type}&font=roboto`}
                alt="Shoes"
              />
            </figure>
            <div className={'card-body flex flex-row items-center'}>
              <div className={'flex flex-col gap-3 flex-1'}>
                <table className={'table'}>
                  <tbody>
                    <tr>
                      <td className={'font-semibold'}>
                        Transactions ID {'  '}
                      </td>
                      <td> {trx.id}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Order ID</td>
                      <td> {trx.order.id}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Created At</td>
                      <td>
                        {' '}
                        {new Date(trx.created_at).toLocaleDateString('id-ID', {
                          year: 'numeric',
                          month: 'long',
                          day: 'numeric',
                          hour: 'numeric',
                          minute: 'numeric',
                          second: 'numeric',
                        })}
                      </td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Payment Type</td>
                      <td> {trx.order.payment_type}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Status</td>
                      <td> {trx.status}</td>
                    </tr>
                    <tr>
                      <td className={'font-semibold'}>Total Payment</td>
                      <td>
                        {' '}
                        {Number(trx.order.total_amount).toLocaleString(
                          'id-ID',
                          {
                            style: 'currency',
                            currency: 'IDR',
                          },
                        )}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}

type Option = {
  label: string
  value: string
}

function ActionsMerchant(props: { data: Merchant }) {
  const { data } = useSession()
  const [status, setStatus] = useState(props.data.status === 'ACTIVE')
  const [badges, setBadge] = useState<SingleValue<Option>>({
    value: props.data.details?.badge ?? '',
    label: props.data.details?.badge ?? '',
  })
  const dialogRef = useRef<HTMLDialogElement>(null)

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
    const url =
      process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL +
      `admin/merchant/${props.data.id}`
    const body: Prisma.merchantUpdateInput = {
      status: checked === true ? 'ACTIVE' : 'BLOCK',
    }
    fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      if (e.ok) {
        setStatus(true)
        window.location.reload()
      } else {
        setStatus(false)
      }
    })
  }

  function handleChangeBadge(newValue: SingleValue<Option>) {
    setBadge(newValue)
    const url =
      process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL +
      `admin/merchant/${props.data.id}`
    const body: Prisma.merchantUpdateInput = {
      details: {
        update: {
          badge: newValue?.value as 'BASIC' | 'REGULAR' | 'PREMIUM',
        },
      },
    }
    fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      if (e.ok) {
        setStatus(true)
      } else {
        setStatus(false)
      }
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
          <h3 className="font-bold text-lg">Update Merchant</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex gap-6 mt-6 items-center'}>
              <h4 className={'font-semibold flex-1'}>Status Merchant</h4>
              <input
                type="checkbox"
                className="toggle"
                checked={status}
                onChange={handleChangeToggle}
              />
            </div>
            <Select
              value={badges}
              onChange={handleChangeBadge}
              options={badge.map((item) => {
                return {
                  label: item,
                  value: item,
                }
              })}
            />
          </div>
          <div className="modal-action">
            <form method="dialog">
              {/* if there is a button in form, it will close the modal */}
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
