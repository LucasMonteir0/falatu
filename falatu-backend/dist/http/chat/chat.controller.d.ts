import { CreateChatDTO } from "./dtos/create_chat.dto";
import { ChatDatasource } from "./datasources/chat.datasource";
export declare class ChatController {
    private readonly datasource;
    constructor(datasource: ChatDatasource);
    createChat(body: CreateChatDTO): Promise<import("./entities/chat.entity").ChatEntity>;
}
