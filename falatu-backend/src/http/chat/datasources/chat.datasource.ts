import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { CreateChatDTO } from "../dtos/create_chat.dto";
import { ChatEntity } from "../entities/chat.entity";

export abstract class ChatDatasource {
  abstract createChat(params: CreateChatDTO): Promise<ResultWrapper<ChatEntity>>;
}
