import { DefaultSession } from 'next-auth'

declare module 'next-auth' {
  /**
   * Returned by `useSession`, `getSession` and received as a prop on the `SessionProvider` React Context
   */
  interface Session {
    id: string
    avatar: string
    token?: string
    role:
      | [
          {
            id: string
            name: string
          },
        ]
      | []
    user: {
      id: string
      email: string
      name: string
      avatar: string
      role:
        | [
            {
              id: string
              name: string
            },
          ]
        | []
      token?: string
    } & DefaultSession['user']
  }

  interface User {
    id: string
    email: string
    name: string
    avatar: string
    token?: string
    role:
      | [
          {
            id: string
            name: string
          },
        ]
      | []
  }
}

declare module 'next-auth/jwt' {
  interface JWT {
    id: string
    avatar: string
    role:
      | [
          {
            id: string
            name: string
          },
        ]
      | []
    user: {
      id: string
      email: string
      name: string
      avatar: string
      role:
        | [
            {
              id: string
              name: string
            },
          ]
        | []
      token?: string
    }
  }
}
