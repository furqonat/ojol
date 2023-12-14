FROM golang:1.21.4
COPY dist/apps/order ./order
COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json
COPY .env ./.env

ENTRYPOINT [ "./order" ]
