import { CreateChatDTO } from "./dtos/create_chat.dto";
import { ChatDatasource } from "./datasources/chat/chat.datasource";
export declare class ChatController {
    private readonly datasource;
    constructor(datasource: ChatDatasource);
    createChat(body: CreateChatDTO): Promise<import("./entities/chat.entity").ChatEntity>;
    getChatsByUserId(userId?: string): Promise<import("./entities/chat.entity").ChatEntity | import("./entities/chat.entity").ChatEntity[]>;
}
