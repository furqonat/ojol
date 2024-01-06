export class UrlService {
  private _query: string

  constructor(private baseUrl: string) {
    this._query = ''
  }

  public addQuery(key: string, value?: string | null) {
    if (!value) {
      return this
    }
    if (this._query.length > 0) {
      this._query += '&'
    }
    this._query += `${key}=${value}`
    return this
  }

  public build(): string {
    if (this._query.length > 0) {
      return `${this.baseUrl}?${this._query}`
    } else {
      return this.baseUrl
    }
  }
}
