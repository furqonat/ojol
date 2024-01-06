import { Metadata } from 'next'
import { OAuthClient } from './page.client'

export const metadata: Metadata = {
  title: 'Oauth dana api',
  description: 'Dana oauth Api',
}

export default function OAuthPage() {
  return <OAuthClient />
}
