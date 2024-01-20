import { Session } from 'next-auth'
import { UrlService } from './url.service'

export class AppService {
  constructor(private urlService: UrlService) {}

  public async fetch(options?: { method?: string; body?: unknown }) {
    const response = await fetch(this.urlService.build(), {
      method: options?.method,
      body: JSON.stringify(options?.body),
    })
    if (!response.ok) {
      throw new Error('response error')
    }
    return await response.json()
  }
}

export function isSuperAdmin(session: Session | null) {
  if (
    session?.user.role.at(0)?.name == 'SUPERADMIN' ||
    session?.user.role.at(0)?.name == 'ADMIN'
  ) {
    return true
  }
  return false
}

export function isKorcapOrKorlap(session: Session | null) {
  if (
    session?.user.role.at(0)?.name == 'KORLAP' ||
    session?.user.role.at(0)?.name == 'KORCAB'
  ) {
    return true
  }
  return false
}

export function uniqueStringAndNumber(length: number): string {
  const characters =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  let result = ''

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length)
    result += characters.charAt(randomIndex)
  }

  return result
}
