import { compare } from 'bcrypt'
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

        const user = await prisma.users.findUnique({
          where: {
            email: credentials.email,
          },
          include: {
            roles: true,
          },
        })
        if (!user) {
          return null
        }
        if (!user.status) {
          return null
        }
        const status = await compare(credentials.password, user.password)
        if (status) {
          return user
        }
        return null
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
        id: token.id,
        name: token.name,
        email: token.email,
        avatar: token.avatar,
      }
      if (user) {
        token.role = user.roles
        token.id = user.id
        token.name = user.name
        token.avatar = user.avatar
      }
      return token
    },

    async session({ session, token }) {
      if (session.user) {
        session.user = token.user
      }
      session.role = token.role
      return session
    },
  },
  debug: process.env.NODE_ENV === 'production',
}
const handler = NextAuth(option)
export { handler as GET, handler as POST }
