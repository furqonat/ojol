import { ValidationPipe } from '@nestjs/common'
import { NestFactory } from '@nestjs/core'
import serverlessExpress from '@vendia/serverless-express'

import { AppModule } from './app/app.module'

import { Handler } from 'express'
import * as admin from 'firebase-admin'
let server: Handler

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
  app.setGlobalPrefix('auth')
  await app.init()
  const expressApp = app.getHttpAdapter().getInstance()
  return serverlessExpress({ app: expressApp })
  // const port = process.env.PORT || 3333
  // await app.listen(port)
  // // Logger.log(
  // //   `🚀 Application is running on: http://localhost:${port}/${globalPrefix}`
  // // )
}

export const handler: Handler = async (event, context, callback) => {
  server = server ?? (await bootstrap())
  return server(event, context, callback)
}
/* bootstrap() */
