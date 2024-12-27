import { MessageType } from "../enums/message_type.enum";
export declare class SendMessageDto {
    senderId: string;
    type: MessageType;
    text?: string;
    mediaUrl?: string;
    constructor({ senderId, type, text, mediaUrl, }: {
        senderId: string;
        type: MessageType;
        text?: string;
        mediaUrl?: string;
    });
}
