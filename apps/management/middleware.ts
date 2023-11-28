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
    secret: 'secret-app',
  },
)

export const config = {
  matcher: ['/((?!auth|api|_next/static|_next/image|favicon.ico).*)'],
}
