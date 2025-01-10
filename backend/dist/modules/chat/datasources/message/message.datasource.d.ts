import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageEntity } from "../../entities/message.entity";
import { SendMessageDto } from "../../dtos/send_message.dto";
export declare abstract class MessageDatasource {
    abstract sendMessage(message: SendMessageDto, chatId: string): Promise<ResultWrapper<MessageEntity>>;
    abstract getMessagesByChatId(id: string): Promise<ResultWrapper<MessageEntity[]>>;
}
