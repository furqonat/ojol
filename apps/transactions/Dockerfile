FROM golang:1.21.4 as build

WORKDIR /apps/transactions

COPY apps/transactions ./
COPY google-services.json ./




RUN go mod tidy & go mod vendor & go build -tags lambda.norpc -o dist/apps/transactions main.go

FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /apps/transactions/dist/apps/transactions ./dist/apps/transactions

COPY --from=build /apps/transactions/.env ./.env

COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json

ENTRYPOINT [ "./dist/apps/transactions" ]
