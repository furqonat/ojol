import { ValidationPipe } from '@nestjs/common'
import { NestFactory } from '@nestjs/core'

import serverlessExpress from '@vendia/serverless-express'
import { Handler, Callback, Context } from 'aws-lambda'
import { AppModule } from './app/app.module'
import { ReplaySubject, firstValueFrom } from 'rxjs'

const serverSubject = new ReplaySubject<Handler>()

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    cors: {
      origin: '*',
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
      preflightContinue: false,
      optionsSuccessStatus: 200,
    },
    logger: ['error'],
  })
  app.useGlobalPipes(new ValidationPipe({ transform: true }))
  await app.init()
  const expressApp = app.getHttpAdapter().getInstance()
  return serverlessExpress({ app: expressApp })
}

bootstrap().then((server) => serverSubject.next(server))

export const handler: Handler = async (
  event: unknown,
  context: Context,
  callback: Callback,
) => {
  const server = await firstValueFrom(serverSubject)
  return server(event, context, callback)
}
