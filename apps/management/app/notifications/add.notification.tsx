'use client'

import { promotion } from '@prisma/client/users'
import { getDownloadURL, getStorage, ref, uploadBytes } from 'firebase/storage'
import { useSession } from 'next-auth/react'
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

  function handleChangeMinFile(e: React.ChangeEvent<HTMLInputElement>) {
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
      const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/promo/'
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
      const body: Partial<promotion> = {
        title: title,
        description: description,
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
                onChange={handleChangeMinFile}
                required={true}
                type={'file'}
                placeholder="Image"
                className={'file-input file-input-bordered'}
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
    </>
  )
}
