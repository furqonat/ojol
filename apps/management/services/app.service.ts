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
