import { discount } from '@prisma/client/users'
import { useSession } from 'next-auth/react'
import { useRef, useState } from 'react'

export function AddDiscount() {
  const { data } = useSession()

  const dialogRef = useRef<HTMLDialogElement>(null)

  const [code, setCode] = useState('')
  const [expiredAt, setExpiredAt] = useState<string>('')
  const [minTrx, setMinTrx] = useState(0)
  const [maxDiscount, setMaxDiscount] = useState(0)
  const [amount, setAmount] = useState(0)
  const [loading, setLoading] = useState(false)

  function handleOpenModal() {
    dialogRef.current?.showModal()
  }

  function handleCloseModal() {
    dialogRef.current?.close()
  }

  function handleChangeCode(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setCode(value)
  }

  function handleChangeExpiredAt(e: React.ChangeEvent<HTMLInputElement>) {
    const { value } = e.target
    setExpiredAt(value)
  }

  function handleChangeMinTrx(e: React.ChangeEvent<HTMLInputElement>) {
    const { valueAsNumber } = e.target
    setMinTrx(valueAsNumber)
  }

  function handleChangeMaxDiscount(e: React.ChangeEvent<HTMLInputElement>) {
    const { valueAsNumber } = e.target
    setMaxDiscount(valueAsNumber)
  }

  function handleChangeAmount(e: React.ChangeEvent<HTMLInputElement>) {
    const { valueAsNumber } = e.target
    setAmount(valueAsNumber)
  }

  async function handleCreateKorlapFee(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setLoading(true)
    const body: Partial<discount> = {
      amount: amount,
      code: code,
      expired_at: new Date(expiredAt),
      max_discount: maxDiscount,
      min_transaction: minTrx,
    }
    const url = process.env.NEXT_PUBLIC_GATE_BASE_URL + 'portal/discount'
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

  return (
    <>
      <button className={'btn btn-outline btn-sm'} onClick={handleOpenModal}>
        Add New
      </button>
      <dialog className="modal" ref={dialogRef}>
        <div className="modal-box flex flex-col gap-4">
          <h3 className="font-bold text-lg">Add new Discount Or Voucher</h3>
          <form onSubmit={handleCreateKorlapFee}>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Code</span>
              </div>
              <input
                value={code}
                onChange={handleChangeCode}
                required={true}
                type={'text'}
                placeholder="discount code"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Amount</span>
              </div>
              <input
                value={amount}
                onChange={handleChangeAmount}
                required={true}
                type={'number'}
                placeholder="Amount"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Expired At</span>
              </div>
              <input
                value={expiredAt}
                onChange={handleChangeExpiredAt}
                required={true}
                type={'date'}
                placeholder="Amount"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Min Transactions</span>
              </div>
              <input
                value={minTrx}
                onChange={handleChangeMinTrx}
                required={true}
                type={'number'}
                placeholder="Amount"
                className="input input-bordered w-full input-sm"
              />
            </label>
            <label className="form-control w-full">
              <div className="label">
                <span className="label-text-alt">Max Discount</span>
              </div>
              <input
                value={maxDiscount}
                onChange={handleChangeMaxDiscount}
                required={true}
                type={'number'}
                placeholder="Amount"
                className="input input-bordered w-full input-sm"
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
