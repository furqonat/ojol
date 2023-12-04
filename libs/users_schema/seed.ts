import { PrismaClient } from '@prisma/client/users'
import * as bcrypt from 'bcrypt'
const prisma = new PrismaClient()
async function main() {
  await prisma.roles.createMany({
    data: [
      {
        id: 'spradmin-1',
        name: 'SUPERADMIN'
      }, {
        id: 'spradmin-2',
        name: 'ADMIN'
      }
    ],
  })

  await prisma.admin.create({
    data: {
      name: 'Furqon Romdhani',
      email: 'furqon@gmail.com',
      password: bcrypt.hashSync('test123', 10),
      role: {
        connect: {
          id: 'spradmin-1'
        }
      }
    }
  })
  await prisma.admin.create({
    data: {
      name: 'Alicia Hamdono',
      email: 'alicia@gmail.com',
      password: bcrypt.hashSync('test123', 10),
      role: {
        connect: {
          id: 'spradmin-2'
        }
      }
    }
  })
}

main().then(() => {
  console.log('database seeded')
}).catch((e) => {
  throw new Error(e)
})