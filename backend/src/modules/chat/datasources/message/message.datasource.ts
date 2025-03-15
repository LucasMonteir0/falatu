import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageEntity } from "../../entities/message.entity";
import { CreateMessageDto } from "../../dtos/create_message.dto";

export abstract class MessageDatasource {
  abstract create(
    message: CreateMessageDto,
    chatId: string
  ): Promise<ResultWrapper<MessageEntity>>;

  abstract getByChat(
    id: string,
    page?: number,
    pageSize?: number
  ): Promise<ResultWrapper<MessageEntity[]>>;

  abstract readMessagesByChat(
    chatId: string,
    userId: string
  ): Promise<ResultWrapper<boolean>>;
}
