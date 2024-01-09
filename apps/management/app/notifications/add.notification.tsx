'use client'

import { getDownloadURL, getStorage, ref, uploadBytes } from 'firebase/storage'
import { useSession } from 'next-auth/react'
import Image from 'next/image'
import { useRef, useState } from 'react'
import Select, { SingleValue } from 'react-select'

const appTypes = ['CUSTOMER', 'MERCHANT', 'DRIVER']
const appOptions = appTypes.map((item) => {
  return {
    value: item,
    label: item,
  }
})

type Option = {
  value: string
  label: string
}
export function AddNotification() {
  const { data } = useSession()

  const dialogRef = useRef<HTMLDialogElement>(null)
  const fileRef = useRef<HTMLInputElement>(null)

  const [title, setTitle] = useState('')
  const [files, setFiles] = useState<FileList | null>(null)
  const [description, setDescription] = useState('')
  const [appType, setAppType] = useState<SingleValue<Option> | null>(null)
  const [loading, setLoading] = useState(false)

  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  function handleChangeTitle(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setTitle(value)
  }

  function handleChangeFile(e: React.ChangeEvent<HTMLInputElement>) {
    const { files } = e.target
    setFiles(files)
  }

  function handleChangeDescription(e: React.ChangeEvent<HTMLTextAreaElement>) {
    const { value } = e.target
    setDescription(value)
  }

  async function handleCreateNotification(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    if (files?.length && files.length > 0) {
      const file = files.item(0)
      const refs = ref(getStorage(), `promotion/${file}`)
      const d = await uploadBytes(refs, file as Blob)
      const link = await getDownloadURL(d.ref)
      const body = {
        title: title,
        body: description,
        image_url: link,
        app_type: appType?.value,
      }
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/promo'
      const resp = await fetch(url, {
        method: 'POST',
        body: JSON.stringify(body),
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
          'Content-Type': 'application/json',
        },
      })
      if (resp.ok) {
        window.location.reload()
      }
    } else {
      const body = {
        title: title,
        body: description,
        app_type: appType?.value,
      }
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/promo'
      const resp = await fetch(url, {
        method: 'POST',
        body: JSON.stringify(body),
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
          'Content-Type': 'application/json',
        },
      })
      if (resp.ok) {
        window.location.reload()
      }
    }
  }

  return (
    <>
      <button className={'btn btn-sm btn-outline'} onClick={handleOpenModal}>
        Add New
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add new Discount Or Voucher</h3>
          <form onSubmit={handleCreateNotification}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Application Type</span>
              </div>
              <Select
                options={appOptions}
                value={appType}
                onChange={(e) => setAppType(e)}
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Title</span>
              </div>
              <input
                value={title}
                onChange={handleChangeTitle}
                required={true}
                type={'text'}
                placeholder="title"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Description</span>
              </div>
              <textarea
                value={description}
                onChange={handleChangeDescription}
                required={true}
                placeholder="Short description"
                className="textarea textarea-bordered"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Image (Optional)</span>
              </div>
              <input
                ref={fileRef}
                onChange={handleChangeFile}
                required={true}
                type={'file'}
                placeholder="Image"
                className={'file-input file-input-bordered'}
              />
            </label>
            {files && files.length > 0 ? (
              <PreviewImgFile
                data={files}
                onDelete={() => {
                  fileRef.current!.value = ''
                  setFiles(null)
                }}
              />
            ) : null}
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
    </>
  )
}

function PreviewImgFile(props: {
  data: FileList
  onDelete: (index: number) => void
}) {
  function handleClickDelete() {
    props.onDelete(0)
  }
  return (
    <div className={'card shadow-sm rounded-md'}>
      <div className={'card-body'}>
        <Image
          width={200}
          height={200}
          src={URL.createObjectURL(props.data.item(0) as Blob)}
          alt={props.data.item(0)?.name ?? ''}
        />
      </div>
      <div className={'card-actions'}>
        <button
          className={'btn-outline btn btn-sm'}
          onClick={handleClickDelete}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth="1.5"
            stroke="currentColor"
            className="w-4 h-4"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"
            />
          </svg>
        </button>
      </div>
    </div>
  )
}
