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
  const [url, setUrl] = useState(props.data?.url ?? '')
  const [description, setDescription] = useState(props.data?.description ?? '')
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
    let body: UpdateBannerBody
    if (files) {
      const imgBody: ImageBody[] = []
      for (const file of files) {
        const storage = getStorage()
        const imgRef = ref(storage, `public/${file.name}`)
        const refUrl = await uploadBytes(imgRef, file)
        const downloadUrl = await getDownloadURL(refUrl.ref)
        imgBody.push({ link: downloadUrl })
      }
      body = {
        position: position?.value,
        for_app: status,
        url: url,
        description: description,
        img: imgBody,
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
    } else {
      body = {
        position: position?.value,
        for_app: status,
        url: url,
        description: description,
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
  }

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
  }

  function handleChangeUrl(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setUrl(value)
  }
  function handleChangeDescription(e: React.ChangeEvent<HTMLTextAreaElement>) {
    const { value } = e.target
    setDescription(value)
  }

  function handleChangeFiles(e: React.ChangeEvent<HTMLInputElement>) {
    const { files } = e.target
    if (files) {
      setFiles(files as unknown as File[])
    }
  }

  console.log(files)

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
                      return <img key={item.id} alt={item.id} src={item.link} />
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
