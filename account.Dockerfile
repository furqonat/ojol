FROM public.ecr.aws/lambda/nodejs:20

COPY apps/account ./apps/account
RUN true
COPY .env ./.env
RUN true
COPY libs/firebase ./libs/firebase
RUN true
COPY libs/bcrypt ./libs/bcrypt
RUN true
COPY libs/guard ./libs/guard
RUN true
COPY libs/guard ./libs/jwtguard
RUN true
COPY libs/users_schema ./libs/users_schema
RUN true
COPY libs/users ./libs/users
RUN true
COPY .eslintignore .
RUN true
COPY .eslintrc.json .
RUN true
COPY .editorconfig .
RUN true
COPY .prettierrc .
RUN true
COPY .prettierignore .
RUN true
COPY jest.config.ts .
RUN true
COPY jest.config.ts .
RUN true
COPY nx.json .
RUN true
COPY google-services.json .

RUN true
COPY package.json .
RUN true
COPY tsconfig.base.json .
RUN true
COPY pnpm-lock.yaml .
RUN true

RUN npm install -g pnpm

RUN pnpm install


RUN npx prisma generate --schema=./libs/users_schema/schema.prisma
RUN true

RUN npx nx run account:build


RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

CMD ["dist/apps/account/main.handler"]