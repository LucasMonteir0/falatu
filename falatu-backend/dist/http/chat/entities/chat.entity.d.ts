import { Chat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
import { UserEntity } from "src/http/commons/entities/user.entity";
export declare class ChatEntity {
    id: string;
    title: string | null;
    pictureUrl?: string | null;
    type: ChatType;
    createdAt: Date;
    users: UserEntity[];
    constructor(id: string, type: ChatType, title: string | null, pictureUrl: string | null, users: UserEntity[], createdAt?: Date);
    static fromPrisma(chat: Chat, users: UserEntity[]): ChatEntity;
}
