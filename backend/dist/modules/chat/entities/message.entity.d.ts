import { Message } from "@prisma/client";
import { MessageType } from "../enums/message_type.enum";
import { UserEntity } from "src/modules/commons/entities/user.entity";
export declare class MessageEntity {
    id: string;
    sender: UserEntity;
    type: MessageType;
    text?: string;
    mediaUrl?: string;
    createdAt: Date;
    constructor({ id, sender, type, createdAt, text, mediaUrl, }: {
        id: string;
        sender: UserEntity;
        type: MessageType;
        createdAt: Date;
        text?: string;
        mediaUrl?: string;
    });
    static fromPrisma(message: Message, sender: UserEntity): MessageEntity;
}
