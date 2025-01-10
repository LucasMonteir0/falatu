import { PrismaService } from "src/utils/config/database/prisma.service";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageDatasource } from "./message.datasource";
import { SendMessageDto } from "../../dtos/send_message.dto";
import { MessageEntity } from "../../entities/message.entity";
export declare class PrismaMessageDatasourceImpl implements MessageDatasource {
    private readonly database;
    constructor(database: PrismaService);
    sendMessage(message: SendMessageDto, chatId: string): Promise<ResultWrapper<MessageEntity>>;
    getMessagesByChatId(id: string): Promise<ResultWrapper<MessageEntity[]>>;
}
