import { NextAuthOptions } from 'next-auth'
import NextAuth from 'next-auth/next'
import CredentialsProvider from 'next-auth/providers/credentials'

const authOptions: NextAuthOptions = {
  providers: [
    CredentialsProvider({
      credentials: {
        email: { label: 'email', type: 'text', placeholder: 'Email' },
        password: {
          label: 'password',
          type: 'password',
          placeholder: 'Password',
        },
      },
      async authorize(credentials) {
        if (!credentials) {
          return null
        }
        console.log(`${process.env.NEXT_PUBLIC_PROD_BASE_URL}/auth/admin`)
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_PROD_BASE_URL}auth/admin`,
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              email: credentials.email,
              password: credentials.password,
            }),
          },
        )
        console.log(response)
        const user = await response.json()
        console.log(user)
        if (!user) {
          return null
        }
        if (!user.status) {
          return null
        }
        return user
      },
    }),
  ],
  session: {
    strategy: 'jwt',
    maxAge: 28800,
    updateAge: 3600,
  },
  secret: process.env.NEXTAUTH_SECRET,
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.picture = user.avatar
        token.role = user.role
        token.user = {
          id: user.id,
          name: user.name,
          email: user.email,
          avatar: user.avatar,
          role: user.role,
          token: user.token,
        }
      }
      return token
    },

    async session({ session, token }) {
      if (session.user) {
        session.user = token.user
      }
      return session
    },
  },
  debug: process.env.NODE_ENV !== 'production',
}
const handler = NextAuth(authOptions)
export { handler as GET, handler as POST }
