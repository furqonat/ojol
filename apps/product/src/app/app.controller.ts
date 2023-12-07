import { RolesGuard } from '@lugo/guard'
import { Controller, UseGuards } from '@nestjs/common'

import { AppService } from './app.service'

@UseGuards(RolesGuard)
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}
}
