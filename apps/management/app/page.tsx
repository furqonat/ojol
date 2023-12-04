/* eslint-disable @next/next/no-img-element */
export default async function Index() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      {/* Stats */}
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Dashboard
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
              <div className={'stat-title'}>Total Users</div>
              <div className={'stat-value text-2xl'}>89,400</div>
              <div className={'stat-desc'}>total users all time</div>
            </div>
          </div>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Total Drivers</div>
              <div className={'stat-value text-2xl'}>3,400</div>
              <div className={'stat-desc'}>total drivers all time</div>
            </div>
          </div>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Total Merchants</div>
              <div className={'stat-value text-2xl'}>2,221</div>
              <div className={'stat-desc'}>total merchants all time</div>
            </div>
          </div>
          <div
            className={
              'stats stats-vertical shadow-sm border border-gray-200 border-solid'
            }
          >
            <div className="stat">
              <div className={'stat-title'}>Total Transactions</div>
              <div className={'stat-value text-2xl'}>1,009,400</div>
              <div className={'stat-desc'}>total transactions in month</div>
            </div>
          </div>
        </section>
        <section className={'mt-5'}>
          <h2 className={'text-lg md:text-xl lg:text-2xl font-semibold'}>
            Top Driver
          </h2>
        </section>
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
                <tr>
                  <th>1</th>
                  <td>
                    <div className="flex items-center gap-3">
                      <div className="avatar">
                        <div className="mask mask-squircle w-12 h-12">
                          <img
                            src="/lugo.png"
                            alt="Avatar Tailwind CSS Component"
                          />
                        </div>
                      </div>
                      <div>
                        <div className="font-bold">Hart Hagerty</div>
                        <div className="text-sm opacity-50">Premium</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    Zemlak, Daniel and Leannon
                    <br />
                    <span className="badge badge-ghost badge-sm">
                      Bike Driver
                    </span>
                  </td>
                  <td>5.000</td>
                  <th>
                    <button className="btn btn-ghost btn-xs">details</button>
                  </th>
                </tr>
                {/* row 2 */}
                <tr>
                  <th>2</th>
                  <td>
                    <div className="flex items-center gap-3">
                      <div className="avatar">
                        <div className="mask mask-squircle w-12 h-12">
                          <img
                            src="/lugo.png"
                            alt="Avatar Tailwind CSS Component"
                          />
                        </div>
                      </div>
                      <div>
                        <div className="font-bold">Brice Swyre</div>
                        <div className="text-sm opacity-50">Premium</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    Carroll Group
                    <br />
                    <span className="badge badge-ghost badge-sm">
                      Car Driver
                    </span>
                  </td>
                  <td>4.500</td>
                  <th>
                    <button className="btn btn-ghost btn-xs">details</button>
                  </th>
                </tr>
                {/* row 3 */}
                <tr>
                  <th>3</th>
                  <td>
                    <div className="flex items-center gap-3">
                      <div className="avatar">
                        <div className="mask mask-squircle w-12 h-12">
                          <img
                            src="/lugo.png"
                            alt="Avatar Tailwind CSS Component"
                          />
                        </div>
                      </div>
                      <div>
                        <div className="font-bold">Marjy Ferencz</div>
                        <div className="text-sm opacity-50">Premium</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    Rowe-Schoen
                    <br />
                    <span className="badge badge-ghost badge-sm">
                      Bike Driver
                    </span>
                  </td>
                  <td>4.350</td>
                  <th>
                    <button className="btn btn-ghost btn-xs">details</button>
                  </th>
                </tr>
                {/* row 4 */}
                <tr>
                  <th>4</th>
                  <td>
                    <div className="flex items-center gap-3">
                      <div className="avatar">
                        <div className="mask mask-squircle w-12 h-12">
                          <img
                            src="/lugo.png"
                            alt="Avatar Tailwind CSS Component"
                          />
                        </div>
                      </div>
                      <div>
                        <div className="font-bold">Yancy Tear</div>
                        <div className="text-sm opacity-50">Premium</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    Wyman-Ledner
                    <br />
                    <span className="badge badge-ghost badge-sm">
                      Bike Driver
                    </span>
                  </td>
                  <td>3.400</td>
                  <th>
                    <button className="btn btn-ghost btn-xs">details</button>
                  </th>
                </tr>
              </tbody>
            </table>
          </div>
        </section>
      </section>
    </main>
  )
}
