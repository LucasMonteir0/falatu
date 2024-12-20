import { Body, Controller, Post } from "@nestjs/common";
import { CreateChatDTO } from "./dtos/create_chat.dto";
import { ChatDatasource } from "./datasources/chat.datasource";

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
}
