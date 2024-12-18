import { MessageType } from "../enums/message_type.enum";
export declare class MessageEntity {
    id: string;
    content: string;
    senderId: string;
    type: MessageType;
    message: string | null;
    mediaUrl: string | null;
    createdAt: Date;
    constructor(id: string, content: string, senderId: string, type: MessageType, createdAt: Date, message: string | null, mediaUrl: string | null);
}
