'use client'

import { services } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import React, { useEffect, useRef, useState } from 'react'

export function Services() {
  const [services, setServices] = useState<services[]>([])
  const { data } = useSession()
  useEffect(() => {
    if (data?.user?.token) {
      fetch(`${process.env.NEXT_PUBLIC_GATE_BASE_URL}portal/services/all`, {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
          'Content-type': 'application/json',
        },
      })
        .then((res) => res.json())
        .then(setServices)
        .catch()
    }
  }, [data?.user.token])

  return (
    <section className={'flex flex-col gap-6'}>
      {services.map((item) => {
        return (
          <div key={item.id} className={'card w-full shadow-sm rounded-none'}>
            <div className={'card-body flex-row items-center'}>
              <div className={'flex-1'}>
                <h3
                  className={`text-lg font-semibold capitalize ${
                    item.enable ? 'text-green-400' : 'text-gray-400'
                  }`}
                >
                  {item.service_type.toLocaleLowerCase()}
                </h3>
                <span>
                  Price Per KM:{' '}
                  {Number(item.price_in_km).toLocaleString('id-ID', {
                    style: 'currency',
                    currency: 'IDR',
                  })}
                </span>
              </div>
              <div className={'card-actions'}>
                <Actions
                  price={item.price_in_km}
                  status={item.enable}
                  id={item.id}
                  name={item.service_type}
                  token={data?.user.token}
                />
              </div>
            </div>
          </div>
        )
      })}
    </section>
  )
}

function Actions(props: {
  status: boolean
  id: string
  name: string
  price: number
  token?: string
}) {
  const [status, setStatus] = useState(props.status ?? false)
  const [price, setPrice] = useState(props.price ?? 0)
  const [loading, setLoading] = useState(false)

  const dialog = useRef<HTMLDialogElement>(null)

  function handleChangeCheckbox(e: React.ChangeEvent<HTMLInputElement>) {
    setStatus(e.target.checked)
  }
  function handleChangePrice(e: React.ChangeEvent<HTMLInputElement>) {
    setPrice(Number(e.target.valueAsNumber))
  }

  function handleSaveAction(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    setLoading(true)
    const body = {
      enable: status,
      price_in_km: price,
      service_type: props.name,
    }
    fetch(
      `${process.env.NEXT_PUBLIC_GATE_BASE_URL}portal/services/${props.id}`,
      {
        method: 'PUT',
        body: JSON.stringify(body),
        headers: {
          Authorization: `Bearer ${props.token}`,
          'Content-Type': 'application/json',
        },
      },
    )
      .then((e) => {
        setLoading(false)
        dialog.current?.close()
      })
      .catch(() => setLoading(false))
  }
  return (
    <div className={'flex flex-row'}>
      <button
        className="btn btn-sm btn-ghost"
        onClick={() => dialog.current?.showModal()}
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
      <dialog ref={dialog} className="modal">
        <div className="modal-box">
          <h3 className="font-bold text-lg capitalize">
            Edit Service {props.name.toLowerCase()}
          </h3>
          <div className={'flex flex-col mt-6 gap-3'}>
            <h3 className={'flex-1 font-semibold'}>Price In KM</h3>
            <input
              type="number"
              className={'input-bordered input input-sm'}
              placeholder={'Price in km'}
              value={price}
              onChange={handleChangePrice}
            />
          </div>
          <div className={'flex flex-row gap-6 items-center mt-6'}>
            <h3 className={'flex-1 font-semibold'}>Service Status</h3>
            <input
              type="checkbox"
              className="toggle"
              checked={status}
              onChange={handleChangeCheckbox}
            />
          </div>

          <div className="modal-action">
            <form method="dialog" className={'flex flex-row gap-6'}>
              <div
                className="btn btn-primary btn-sm"
                onClick={handleSaveAction}
              >
                Save{' '}
                {loading ? <span className={'loading loading-bars'} /> : null}
              </div>
              <button className="btn btn-sm">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </div>
  )
}
