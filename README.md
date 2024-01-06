# Lugo Application Services

This project is services for lugo application. This services contains 
- authentication
- account
- cart
- finance
- management
- order
- product
- transactions

## Get Started
This application using <a href="https://nx.dev/">Nx Monorepo</a> for build system and managing code base. Nx Monorepo using nodejs to start, if you have no idea what is Nx Monorepo please go to Nx Monorepo documentation to start.


## Develop Services
Before we jump into code and making more feature for all services that we have, we need install all dependencies and generate <a href="https://prisma.io">Prisma</a> schema.

#### Install Typescript services dependencies
```bash
pnpm install
```
#### Install Golang services dependencies

```bash
cd <golang>/<project> && go get .
```

#### Generate Prisma schema for Typescript services
```bash
npx prisma generate --schema ./libs/schema/schema.prisma
```

#### Generate Prisma schema for Golang services
```bash
npx nx run <golang-service-name>:generate-db
# npx nx run transactions:generate-db
```
if you got an error while generating Prisma schema for Golang services. Try to comment or remove `DIRECT_URL` and `DATABASE_URL` in Golang service root folder before generate schema. Don't forget to add back that variable after finish generate schema.

##### Before
```bash
DIRECT_URL='.......'
DATABASE_URL='.......'
```
##### After
```bash
#DIRECT_URL='.......'
#DATABASE_URL='.......'
```

### <p style="color: #f03c15;">NEVER DO THIS ACTION</p>
When developing new features sometimes we need change prisma schema and sync prisma into uor database. Please use migration command to sync prisma schema into database.

#### <p style="color: #f03c15;">DANGER COMMAND</p>
```bash
npx prisma db push
```

#### <p style="color: yellow;">WARNING ACTION</p>
```bash
npx prisma migrate dev
```

#### <p style="color: green;">SAFE ACTION</p>
Please use your local postgressql database to developing new features. How to use your local database? Change the `DATABASE_URL` and `DIRECT_URL` in `.env` file with your local postgress connection

