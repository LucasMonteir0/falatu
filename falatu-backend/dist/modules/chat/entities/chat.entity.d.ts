import { Chat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
import { ChatUserEntity } from "./chat_user.entity";
export declare class ChatEntity {
    id: string;
    title: string | null;
    pictureUrl?: string | null;
    type: ChatType;
    createdAt: Date;
    users: ChatUserEntity[];
    constructor(id: string, type: ChatType, title: string | null, pictureUrl: string | null, users: ChatUserEntity[], createdAt?: Date);
    static fromPrisma(chat: Chat, users: ChatUserEntity[]): ChatEntity;
}
