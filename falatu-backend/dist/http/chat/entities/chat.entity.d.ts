import { Chat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
export declare class ChatEntity {
    id: string;
    title: string | null;
    pictureUrl: string | null;
    type: ChatType;
    createdAt: Date;
    constructor(id: string, type: ChatType, title: string | null, pictureUrl: string | null, createdAt?: Date);
    static fromPrisma(chat: Chat): ChatEntity;
}
