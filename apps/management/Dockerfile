FROM node:20

WORKDIR /management


COPY apps/management ./apps/management
RUN true
COPY apps/management/.env ./.env
RUN true
COPY libs/firebase ./libs/firebase
RUN true
COPY libs/bcrypt ./libs/bcrypt
RUN true
COPY libs/guard ./libs/guard
RUN true
COPY libs/jwtguard ./libs/jwtguard
RUN true
COPY libs/common ./libs/common
RUN true
COPY libs/schema ./libs/schema
RUN true
COPY libs/prisma ./libs/prisma
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

RUN sed -i '/"@nx\/cypress": "17.1.3",/d' package.json
RUN true
RUN sed -i '/"cypress": "^13.0.0",/d' package.json
RUN true

RUN npm install -g pnpm

RUN pnpm install


RUN npx prisma generate --schema=./libs/schema/schema.prisma
RUN true

RUN npx nx run management:build


RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json
RUN export JWT_SECRET=auth-secret-1234

CMD ["npx", "next", "start", "/management/dist/apps/management"]
