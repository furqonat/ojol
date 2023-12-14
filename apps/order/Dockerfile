FROM public.ecr.aws/lambda/provided:al2023
COPY dist/apps/order ./order
COPY google-services.json ./google-services.json

RUN export GOOGLE_APPLICATION_CREDENTIALS=google-services.json
COPY .env ./.env

ENTRYPOINT [ "./order" ]
