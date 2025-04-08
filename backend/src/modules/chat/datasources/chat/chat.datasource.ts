import { ResultWrapper } from "src/modules/commons/utils/result/ResultWrapper";
import { CreateChatDTO } from "../../dtos/create_chat.dto";
import { ChatEntity } from "../../entities/chat.entity";
import { ChatUserEntity } from "../../entities/chat_user.entity";

export abstract class ChatDatasource {
  abstract createChat(
    params: CreateChatDTO
  ): Promise<ResultWrapper<ChatEntity>>;
  abstract getChatById(id: string): Promise<ResultWrapper<ChatEntity>>;
  abstract getChatsByUserId(id: string): Promise<ResultWrapper<ChatEntity[]>>;
  abstract getUsersByChatId(
    id: string
  ): Promise<ResultWrapper<ChatUserEntity[]>>;
  abstract updateLastMessage(
    chatId: string,
    messageId: string
  ): Promise<ResultWrapper<ChatEntity>>;
}
