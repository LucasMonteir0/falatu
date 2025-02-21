import { Controller, Get, Query } from "@nestjs/common";
import { MessageDatasource } from "./datasources/message/message.datasource";

@Controller("messages")
export class MessageController {
  constructor(private readonly datasource: MessageDatasource) {}

  @Get()
  async getChatsByUserId(@Query("chatId") userId: string) {
    const result = await this.datasource.getByChat(userId);
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }
}