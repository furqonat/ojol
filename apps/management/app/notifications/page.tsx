import { Notification } from './notification'
import { AddNotification } from './add.notification'

export default function NotificationsPage() {
  return (
    <main className={'container py-6 px-4 md:px-0'}>
      <section className={'flex flex-col gap-5'}>
        <div className={'flex flex-row gap-2 items-center'}>
          <div className={'flex-1'}>
            <h2 className={'text-xl md:text-2xl lg:text-3xl font-semibold'}>
              Notifications
            </h2>
          </div>
          <div>
            <AddNotification />
          </div>
        </div>
        <Notification />
      </section>
    </main>
  )
}
