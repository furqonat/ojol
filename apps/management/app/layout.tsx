import { PageProvider } from '../provider'
import './global.css'

import { Open_Sans } from 'next/font/google'

const openSans = Open_Sans({ weight: '400', subsets: ['latin'] })

export const metadata = {
  title: 'Welcome to management lugo',
  description: 'This website for admin management lugo application',
}

type LayoutType = {
  children: React.ReactNode
}

export default function RootLayout({ children }: LayoutType) {
  return (
    <html lang={'en'} data-theme={'light'}>
      <body className={openSans.className}>
        <PageProvider>{children}</PageProvider>
      </body>
    </html>
  )
}
