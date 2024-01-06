FROM golang:1.21.5


COPY apps/order/ ./apps/order

COPY .env ./.env

COPY libs/schema/schema.prisma apps/order/schema.prisma

RUN go version
RUN cd apps/order && go get .
RUN cd apps/order && go get github.com/steebchen/prisma-client-go

RUN sed -i '15i\generator db {\n provider ="go run github.com/steebchen/prisma-client-go" \n}'  apps/order/schema.prisma
RUN sed -i '/generator client {/,/}/d' apps/order/schema.prisma
RUN cd apps/order && go run github.com/steebchen/prisma-client-go generate --schema=schema.prisma
RUN rm apps/order/schema.prisma
RUN cd apps/order && go mod tidy && go mod vendor && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -tags lambda.norpc -o ../../dist/apps/order main.go

COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

CMD [ "./dist/apps/order" ]
