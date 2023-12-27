FROM golang:1.21.5

COPY apps/gate/ ./apps/gate

COPY .env ./.env

COPY libs/schema/schema.prisma apps/gate/schema.prisma

RUN go version
# RUN cd apps/gate && rm -r vendor
RUN cd apps/gate && go get .
RUN cd apps/gate && go get github.com/steebchen/prisma-client-go

RUN sed -i '15i\generator db {\n provider ="go run github.com/steebchen/prisma-client-go" \n}'  apps/gate/schema.prisma
RUN sed -i '/generator client {/,/}/d' apps/gate/schema.prisma
RUN cd apps/gate && go run github.com/steebchen/prisma-client-go generate --schema=schema.prisma
RUN rm apps/gate/schema.prisma

RUN cd apps/gate && go mod tidy && go mod vendor && go build -tags lambda.norpc -o ../../dist/apps/gate main.go

COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

ENTRYPOINT [ "./dist/apps/gate" ]
