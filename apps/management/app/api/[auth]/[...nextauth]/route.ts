import { NextAuthOptions } from 'next-auth'
import NextAuth from 'next-auth/next'
import CredentialsProvider from 'next-auth/providers/credentials'

const option: NextAuthOptions = {
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

        const response = await fetch(`${process.env.BASE_URL}auth/admin`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            email: credentials.email,
            password: credentials.password,
          }),
        })

        const user = await response.json()
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
  secret: 'secret-app',
  callbacks: {
    async jwt({ token, user }) {
      token.user = {
        id: user.id,
        name: user.name,
        email: user.email,
        avatar: user.avatar,
        role: user.role,
      }
      if (user) {
        token.id = user.id
        token.name = user.name
        token.email = user.email
        token.avatar = user.avatar
        token.role = user.role
      }
      return token
    },

    async session({ session, token }) {
      if (session.user) {
        session.user = token.user
      }
      session.user.role = token.user.role
      return session
    },
  },
  debug: process.env.NODE_ENV !== 'production',
}
const handler = NextAuth(option)
export { handler as GET, handler as POST }
