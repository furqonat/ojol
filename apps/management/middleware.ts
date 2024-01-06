import { withAuth } from 'next-auth/middleware'
export default withAuth(
  function middleware(req) {
    //
  },
  {
    callbacks: {
      authorized: ({ token }) => {
        if (token === null) {
          return false
        }
        return true
      },
    },
    pages: {
      signIn: '/auth',
    },
    secret:
      'eyJhbGciOiJIUzUxMiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTcwMTY2MjA3MywiaWF0IjoxNzAxNjYyMDczfQ.A5iud4Cp8vb749hz4ifJJ-M5mzZfekoU7L1HKCxKVhqvB1W8q9wE3_NgqvljaOAqdCcVhfXan09vCKplr1OK7A',
  },
)

export const config = {
  matcher: ['/((?!auth|api|_next/static|_next/image|favicon.ico).*)'],
}
