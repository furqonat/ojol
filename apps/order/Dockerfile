FROM golang:1.21.4 as build

WORKDIR /apps/order

COPY apps/order .
RUN echo -e "go 1.21.4 \n\nuse apps/order" > go.work
COPY go.work.sum /go.work.sum


RUN go mod tidy & go mod vendor & go build -tags lambda.norpc -o dist/apps/order main.go 

FROM public.ecr.aws/lambda/provided:al2023
COPY --from=build /apps/order/dist/apps/order ./dist/apps/order
COPY --from=build /apps/order/.env ./dist/apps/.env
COPY --from=build /apps/order/.env ./.env

ENTRYPOINT [ "./dist/apps/order" ]