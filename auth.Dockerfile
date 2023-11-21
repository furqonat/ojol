FROM public.ecr.aws/lambda/nodejs:20

COPY apps/auth ./apps/auth
RUN true
COPY apps/auth/.env ./.env
COPY firebase ./firebase
RUN true
COPY bcrypt ./bcrypt
RUN true
COPY guard ./guard
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


RUN npx prisma generate --schema=./apps/auth/prisma/schema.prisma
RUN true

RUN npx nx run auth:build


RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

CMD ["dist/apps/auth/main.handler"]