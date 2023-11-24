import './global.css'

import { Poppins } from 'next/font/google'

const poppins = Poppins({ weight: '400', subsets: ['latin'] })

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
      <body className={poppins.className}>{children}</body>
    </html>
  )
}
