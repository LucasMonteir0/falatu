import { Module } from '@nestjs/common';
import { ChatDatasource } from './datasources/chat.datasource';
import { PrismaChatDatasourceImpl } from './datasources/prisma_chat.datasource';
import { ChatController } from './chat.controller';

@Module({
  imports: [],
  controllers: [ChatController],
  providers: [ {
        provide: ChatDatasource,
        useClass: PrismaChatDatasourceImpl,
      },],
})
export class ChatModule {}
