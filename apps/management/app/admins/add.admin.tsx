'use client'

import { uniqueStringAndNumber } from '../../services/app.service'
import { useSession } from 'next-auth/react'
import React, { useEffect, useRef, useState } from 'react'
import Select from 'react-select'
import { ToastContainer, toast } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'
import { UrlService } from '../../services/url.service'

type OptionValue = {
  label: string
  value: string
}

export function AddAdmin() {
  const dialogRef = useRef<HTMLDialogElement>(null)
  const { data } = useSession()
  const [options, setOptions] = useState<OptionValue[]>([])

  const [loading, setLoading] = useState(false)
  const [roleId, setRoleId] = useState('')
  const [roleName, setRoleName] = useState('')
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  function handleChangeName(e: React.ChangeEvent<HTMLInputElement>) {
    setName(e.target.value)
  }
  function handleChangeEmail(e: React.ChangeEvent<HTMLInputElement>) {
    setEmail(e.target.value)
  }
  function handleChangePassword(e: React.ChangeEvent<HTMLInputElement>) {
    setPassword(e.target.value)
  }

  function handleOnCreateAdmin(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    if (!roleId) {
      setLoading(false)
      if (!toast.isActive('roleId')) {
        toast.error('Role id must filled', {
          toastId: 'roleId',
        })
      }
      return
    }
    let body
    if (roleName === 'KORLAP' || roleName === 'KORCAB') {
      body = {
        name: name,
        email: email,
        password: password,
        roleId: roleId,
        ref: uniqueStringAndNumber(12),
      }
    } else {
      body = {
        name: name,
        email: email,
        password: password,
        roleId: roleId,
      }
    }
    fetch(`${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/`, {
      method: 'POST',
      body: JSON.stringify(body),
      headers: {
        Authorization: `Bearer ${data?.user.token}`,
        'Content-Type': 'application/json',
      },
    })
      .then((e) => e.json())
      .then((_) => {
        setLoading(false)
        window.location.reload()
      })
      .catch((e) => {
        setLoading(false)
        if (!toast.isActive('error-create-admin')) {
          toast.error(`unable create admin ${e.toString()}`, {
            toastId: 'error-create-admin',
          })
        }
      })
  }

  useEffect(() => {
    if (data?.user.token) {
      const url = new UrlService(
        `${process.env.NEXT_PUBLIC_ACCOUNT_BASE_URL}admin/roles`,
      )
      fetch(url.build(), {
        headers: {
          Authorization: `Bearer ${data?.user.token}`,
        },
      })
        .then((e) => e.json())
        .then((e) => {
          const value = e.map((item: { name: string; id: string }) => ({
            value: item.id,
            label: item.name,
          }))
          setOptions(value)
        })
    }
  }, [data?.user.token])

  return (
    <div>
      <button className={'btn btn-outline btn-md'} onClick={handleOpenModal}>
        Add Admin
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add new admin</h3>
          <form onSubmit={handleOnCreateAdmin}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Name</span>
              </div>
              <input
                required={true}
                type="text"
                value={name}
                onChange={handleChangeName}
                placeholder="Admin Name"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Email</span>
              </div>
              <input
                value={email}
                onChange={handleChangeEmail}
                type={'email'}
                autoComplete={'one-time-code'}
                required={true}
                placeholder="Admin email"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Password</span>
              </div>
              <input
                value={password}
                onChange={handleChangePassword}
                required={true}
                autoComplete={'one-time-code'}
                type="password"
                placeholder="Admin Password"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className={'form-control w-full'}>
              <div className="label">
                <span className="label-text-alt">Role</span>
              </div>
              <Select
                options={options}
                onChange={(e) => {
                  setRoleName(e?.label ?? '')
                  setRoleId(e?.value ?? '')
                }}
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
      <ToastContainer />
    </div>
  )
}
