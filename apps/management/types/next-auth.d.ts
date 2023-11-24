import { DefaultSession } from 'next-auth'

declare module 'next-auth' {
  /**
   * Returned by `useSession`, `getSession` and received as a prop on the `SessionProvider` React Context
   */
  interface Session {
    user: {
      /** The user's postal address. */
      id: string
      email: string
      name: string
      avatar: string
      role: []
    } & DefaultSession['user']
  }

  interface User {
    id: string
    id: string
    email: string
    name: string
    avatar: string
    role: []
  }
}

declare module 'next-auth/jwt' {
  interface JWT {
    user: {
      id: string
      email: string
      name: string
      avatar: string
      role: []
    } & DefaultSession['user']
  }
}
