import { Controller, Get, Query } from "@nestjs/common";
import { MessageDatasource } from "./datasources/message/message.datasource";

@Controller("messages")
export class MessageController {
  constructor(private readonly datasource: MessageDatasource) {}

  @Get()
  async getByChat(@Query("chatId") userId: string, @Query("page")page: number) {
    const result = await this.datasource.getByChat(userId, page);
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }
}