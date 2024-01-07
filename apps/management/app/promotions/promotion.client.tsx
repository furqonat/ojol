/* eslint-disable @next/next/no-img-element */
'use client'

import { Prisma, banner, banner_images } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import React, { useEffect, useRef, useState } from 'react'
import Select, { SingleValue } from 'react-select'
import { getDownloadURL, getStorage, ref, uploadBytes } from 'firebase/storage'

type Banner = banner & {
  images: banner_images[] | null | undefined
}

export function Promotion() {
  const [banners, setBanners] = useState<Banner[]>([])
  const { data } = useSession()

  useEffect(() => {
    if (data?.user.token) {
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/banner'
      fetch(url, {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then(setBanners)
    }
  }, [data?.user.token])

  return (
    <section className={'flex flex-col gap-6'}>
      {banners?.map((item) => {
        return (
          <div key={item.id} className={'card shadow-md'}>
            <div className={'card-body'}>
              <div className={'flex w-full'}>
                <h3 className={'card-title flex-1'}>
                  {item.for_app
                    ? `Customer App Banner | ${item.position}`
                    : 'Merchant App Banner'}
                </h3>
                <UpdateBanner data={item} />
              </div>
            </div>
          </div>
        )
      })}
    </section>
  )
}

type ImageBody = {
  url: string | null
  description: string | null
  link: string
}

type UpdateBannerBody = Prisma.bannerUpdateInput & {
  img?: ImageBody[]
}

function UpdateBanner(props: { data: Banner }) {
  console.log(props.data)
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)
  const [status, setStatus] = useState(props.data.for_app ?? false)
  const [position, setPosition] = useState<
    SingleValue<{
      value: 'TOP' | 'BOTTOM'
      label: string
    }>
  >({
    value: props.data.position,
    label: props.data.position,
  })
  const [files, setFiles] = useState<File[]>([])

  async function handleOnSave(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const url =
      process.env.NEXT_PUBLIC_GATE_BASE_URL + `portal/banner/${props.data.id}`
    const body = {
      position: position?.value,
      for_app: status,
    }
    const resp = await fetch(url, {
      method: 'PUT',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    })
    if (resp.ok) {
      dialogRef?.current?.close()
      window.location.reload()
    }
  }

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
  }

  function handleChangeFiles(e: React.ChangeEvent<HTMLInputElement>) {
    const { files } = e.target
    if (files) {
      setFiles(files as unknown as File[])
    }
  }

  return (
    <>
      <button
        className="btn btn-sm btn-outline"
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
          <h3 className="font-bold text-lg">Update Banner</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex flex-col gap-6 mt-6 items-center'}>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Position</span>
                </div>
                <Select
                  placeholder={'banner position'}
                  value={position}
                  options={[
                    {
                      value: 'TOP',
                      label: 'TOP',
                    },
                    {
                      value: 'BOTTOM',
                      label: 'BOTTOM',
                    },
                  ]}
                  onChange={(e) => setPosition(e)}
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Used For</span>
                </div>
                <div className={'flex w-full'}>
                  <span className={'flex-1'}>Customer Application?</span>
                  <input
                    type="checkbox"
                    className="toggle"
                    checked={status}
                    onChange={handleChangeToggle}
                  />
                </div>
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Image</span>
                </div>
                <input
                  placeholder={'chose image'}
                  type="file"
                  multiple={true}
                  className="file-input w-full max-w-xs"
                  onChange={handleChangeFiles}
                />
                {props.data?.images ? (
                  <>
                    {props.data?.images.map((item) => {
                      return (
                        <PreviewImage
                          images={{
                            link: item.link,
                            url: item?.url,
                            description: item?.description,
                          }}
                          key={item.id}
                        />
                      )
                    })}
                  </>
                ) : null}
              </label>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex gap-6'}>
              <div className="btn btn-primary" onClick={handleOnSave}>
                Save
              </div>
              <button className="btn">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}

function PreviewImage(props: { images: ImageBody }) {
  const { images } = props

  const [url, setUrl] = useState(images?.url ?? '')
  const [description, setDescription] = useState(images?.description ?? '')

  function handleChangeUrl(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setUrl(value)
  }
  function handleChangeDescription(e: React.ChangeEvent<HTMLTextAreaElement>) {
    const { value } = e.target
    setDescription(value)
  }
  return (
    <div className={'card shadow-sm'}>
      <div className={'card-body'}>
        <div className={'flex flex-col gap-6'}>
          <img
            alt={images.url ?? ''}
            className={'rounded-md'}
            src={images.link}
          />
          <label className="form-control w-full">
            <div className="label">
              <span className="label-text-alt">Url</span>
            </div>
            <input
              placeholder={'website url eg: https://lugo.com'}
              type="text"
              className="input input-bordered"
              value={url}
              onChange={handleChangeUrl}
            />
          </label>
          <label className="form-control w-full">
            <div className="label">
              <span className="label-text-alt">Description</span>
            </div>
            <textarea
              placeholder={'description banner'}
              className={'textarea textarea-bordered'}
              value={description}
              onChange={handleChangeDescription}
            />
          </label>
        </div>
        <div className={'card-actions'}>
          <button
            className={'btn-outline btn btn-sm'}
            onClick={() => {
              window.open(images.link, 'noopener noreferrer')
            }}
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
                d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z"
              />
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
              />
            </svg>
          </button>
          <button
            className={'btn-outline btn btn-sm'}
            onClick={() => {
              // window.open(images.link, 'noopener noreferrer')
            }}
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              className="w-4 h-4"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"
              />
            </svg>
          </button>
        </div>
      </div>
    </div>
  )
}
