import serverlessExpress from '@vendia/serverless-express'
import { ValidationPipe } from '@nestjs/common'
import { NestFactory } from '@nestjs/core'

import { AppModule } from './app/app.module'

import { Handler } from 'express'
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
  await app.init()
  const expressApp = app.getHttpAdapter().getInstance()
  return serverlessExpress({ app: expressApp })
  // const port = process.env.PORT || 3333
  // await app.listen(port)
  // // Logger.log(
  // //   `🚀 Application is running on: http://localhost:${port}/${globalPrefix}`
  // // )
}

const handler: Handler = async (event, context, callback) => {
  server = server ?? (await bootstrap())
  return server(event, context, callback)
}

export { handler }
/* bootstrap() */
