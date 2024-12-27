import { Body, Controller, Get, Post, Query } from "@nestjs/common";
import { CreateChatDTO } from "./dtos/create_chat.dto";
import { ChatDatasource } from "./datasources/chat/chat.datasource";

@Controller("chats")
export class ChatController {
  constructor(private readonly datasource: ChatDatasource) {}

  @Post()
  async createChat(@Body() body: CreateChatDTO) {
    const result = await this.datasource.createChat(body);

    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }
  @Get()
  async getChatsByUserId(@Query("userId") userId?: string) {
    const result = await this.datasource.getChatsByUser(userId);
    if (result.isSuccess) {
      if (!userId) {
        return result.data;
      }
      return result.data[0];
    }
    throw result.error;
  }
}
