FROM golang:1.21.4 as build

WORKDIR /apps/transactions

COPY apps/transactions ./
COPY go.work /go.work
COPY go.work.sum /go.work.sum


RUN ls .
RUN go mod tidy & go mod vendor & go build -tags lambda.norpc -o dist/apps/transactions main.go 

FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /apps/transactions/dist/apps/transactions ./dist/apps/transactions

ENTRYPOINT [ "./dist/apps/transactions" ]