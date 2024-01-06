import { ServiceFee } from './service.fee'

export default function FinancialPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      {/* Stats */}
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Finance
            </h2>
          </div>
          <div>
            <div className={'dropdown dropdown-end'}>
              <div
                tabIndex={0}
                role={'button'}
                className={'btn btn-outline btn-md'}
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
                    d="M6 13.5V3.75m0 9.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 3.75V16.5m12-3V3.75m0 9.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 3.75V16.5m-6-9V3.75m0 3.75a1.5 1.5 0 010 3m0-3a1.5 1.5 0 000 3m0 9.75V10.5"
                  />
                </svg>
                Filter
              </div>
              <ul
                tabIndex={0}
                className={
                  'dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52'
                }
              >
                <li>
                  <a>All time</a>
                </li>
                <li>
                  <a>Year</a>
                </li>
                <li>
                  <a>Month</a>
                </li>
                <li>
                  <a>Day</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <section className={'grid grid-cols-2 lg:grid-cols-4 gap-4'}>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Total Balance </div>
              <div className={'stat-value text-2xl'}>89,400</div>
              <div className={'stat-desc'}>total balance in month</div>
            </div>
          </div>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Gross Profit</div>
              <div className={'stat-value text-2xl'}>89,400</div>
              <div className={'stat-desc'}>before fees</div>
            </div>
          </div>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Gross Profit</div>
              <div className={'stat-value text-2xl'}>89,400</div>
              <div className={'stat-desc'}>before korlap & korcap fee</div>
            </div>
          </div>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Total Net Profit</div>
              <div className={'stat-value text-2xl'}>89,400</div>
              <div className={'stat-desc'}>total net profit in month</div>
            </div>
          </div>
        </section>
        <ServiceFee />
      </section>
    </main>
  )
}
