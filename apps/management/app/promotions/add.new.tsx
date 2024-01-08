'use client'

import { Prisma } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useRef, useState } from 'react'
import Select from 'react-select'

export function AddNew() {
  const { data } = useSession()
  const dialogRef = useRef<HTMLDialogElement>(null)
  const [status, setStatus] = useState(false)
  const [position, setPosition] = useState<'TOP' | 'BOTTOM'>('TOP')

  function handleOnSave(e: React.MouseEvent<HTMLDivElement>) {
    e.preventDefault()
    const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + `portal/banner`
    const body: Prisma.bannerCreateInput = {
      position: position,
      for_app: status,
    }
    fetch(url, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${data?.user?.token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    }).then((e) => {
      dialogRef.current?.close()
    })
  }

  function handleChangeToggle(e: React.ChangeEvent<HTMLInputElement>) {
    const { checked } = e.target
    setStatus(checked)
  }

  return (
    <>
      <button
        className="btn btn-sm btn-outline"
        onClick={() => dialogRef.current?.showModal()}
      >
        Add New
      </button>
      <dialog ref={dialogRef} className="modal">
        <div className="modal-box">
          <h3 className="font-bold text-lg">Create Banner</h3>
          <div className={'flex flex-col gap-6'}>
            <div className={'flex flex-col gap-6 mt-6 items-center'}>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">Position</span>
                </div>
                <Select
                  options={[
                    {
                      label: 'TOP',
                      value: 'TOP',
                    },
                    {
                      label: 'BOTTOM',
                      value: 'BOTTOM',
                    },
                  ]}
                  onChange={(e) => setPosition(e?.value as 'TOP' | 'BOTTOM')}
                />
              </label>
              <label className="form-control w-full">
                <div className="label">
                  <span className="label-text-alt">For Customer App</span>
                </div>
                <input
                  type="checkbox"
                  className="toggle"
                  checked={status}
                  onChange={handleChangeToggle}
                />
              </label>
            </div>
          </div>
          <div className="modal-action">
            <form method="dialog" className={'flex items-center gap-3'}>
              <div className="btn btn-primary btn-sm" onClick={handleOnSave}>
                Save
              </div>
              <button className="btn btn-sm">Close</button>
            </form>
          </div>
        </div>
      </dialog>
    </>
  )
}
