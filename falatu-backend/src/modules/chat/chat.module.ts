import { Module } from "@nestjs/common";
import { ChatController } from "./chat.controller";
import { ChatGateway } from "src/modules/chat/gateways/chat.gateway";
import { ChatDatasource } from "./datasources/chat/chat.datasource";
import { PrismaChatDatasourceImpl } from "./datasources/chat/prisma_chat.datasource";
import { MessageDatasource } from "./datasources/message/message.datasource";
import { PrismaMessageDatasourceImpl } from "./datasources/message/prisma_message.datasource";
import { MessagesGateway } from "./gateways/messages.gateway";

@Module({
  imports: [],
  controllers: [ChatController],
  providers: [
    {
      provide: ChatDatasource,
      useClass: PrismaChatDatasourceImpl,
    },
    {
      provide: MessageDatasource,
      useClass: PrismaMessageDatasourceImpl,
    },
    ChatGateway,
    MessagesGateway,
  ],
})
export class ChatModule {}
