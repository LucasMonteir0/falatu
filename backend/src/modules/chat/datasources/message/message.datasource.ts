import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageEntity } from "../../entities/message.entity";
import { CreateMessageDto } from "../../dtos/create_message_dto";

export abstract class MessageDatasource {
  abstract create(
    message: CreateMessageDto,
    chatId: string
  ): Promise<ResultWrapper<MessageEntity>>;
  abstract getByChat(id: string): Promise<ResultWrapper<MessageEntity[]>>;
  abstract updateMessageRead(
    messageId: string,
    userId: string
  ): Promise<ResultWrapper<MessageEntity>>;
}
