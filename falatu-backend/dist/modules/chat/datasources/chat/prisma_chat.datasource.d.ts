import { CreateChatDTO } from "../../dtos/create_chat.dto";
import { ChatEntity } from "../../entities/chat.entity";
import { ChatDatasource } from "./chat.datasource";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
export declare class PrismaChatDatasourceImpl implements ChatDatasource {
    private readonly database;
    constructor(database: PrismaService);
    getChatsByUser(id: string): Promise<ResultWrapper<ChatEntity[]>>;
    getChatById(id: string): Promise<ResultWrapper<ChatEntity>>;
    createChat(params: CreateChatDTO): Promise<ResultWrapper<ChatEntity>>;
}
