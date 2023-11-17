import { Logger, ValidationPipe } from '@nestjs/common'
import { NestFactory } from '@nestjs/core'

import { AppModule } from './app/app.module'

import * as admin from 'firebase-admin'

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    cors: {
      origin: '*',
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
      preflightContinue: false,
      optionsSuccessStatus: 200,
    },
  })
  app.useGlobalPipes(new ValidationPipe())
  const adminApp = admin.apps.find((app) => app.name === '[DEFAULT]')
  if (!adminApp) {
    admin.initializeApp()
  }
  await app.init()
  // const expressApp = app.getHttpAdapter().getInstance()
  // return serverlessExpress({ app: expressApp })
  const port = process.env.PORT || 3333
  await app.listen(port)
  Logger.log(`🚀 Application is running on: http://localhost:${port}`)
}

bootstrap()
