FROM golang:1.21.5

COPY apps/utility/ ./apps/utility

COPY .env ./.env

COPY libs/schema/schema.prisma apps/utility/schema.prisma

RUN go version
# RUN cd apps/utility && rm -r vendor
RUN cd apps/utility && go get .
RUN cd apps/utility && go get github.com/steebchen/prisma-client-go

RUN sed -i '15i\generator db {\n provider ="go run github.com/steebchen/prisma-client-go" \n}'  apps/utility/schema.prisma
RUN sed -i '/generator client {/,/}/d' apps/utility/schema.prisma
RUN cd apps/utility && go run github.com/steebchen/prisma-client-go generate --schema=schema.prisma
RUN rm apps/utility/schema.prisma

RUN cd apps/utility && go mod tidy && go mod vendor && go build -tags lambda.norpc -o ../../dist/apps/utility main.go

COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

ENTRYPOINT [ "./dist/apps/utility" ]
