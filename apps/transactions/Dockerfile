FROM golang:1.21.5

COPY apps/transactions/ ./apps/transactions

COPY .env ./.env

COPY libs/schema/schema.prisma apps/transactions/schema.prisma

RUN go version
# RUN cd apps/transactions && rm -r vendor
RUN cd apps/transactions && go get .
RUN cd apps/transactions && go get github.com/steebchen/prisma-client-go

RUN sed -i '15i\generator db {\n provider ="go run github.com/steebchen/prisma-client-go" \n}'  apps/transactions/schema.prisma
RUN sed -i '/generator client {/,/}/d' apps/transactions/schema.prisma
RUN cd apps/transactions && go run github.com/steebchen/prisma-client-go generate --schema=schema.prisma
RUN rm apps/transactions/schema.prisma

RUN cd apps/transactions && go mod tidy && go mod vendor && go build -tags lambda.norpc -o ../../dist/apps/transactions main.go

COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

CMD [ "./dist/apps/transactions" ]
