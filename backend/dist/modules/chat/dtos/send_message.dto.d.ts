import { MessageType } from "../enums/message_type.enum";
export declare class SendMessageDto {
    senderId: string;
    type: MessageType;
    text?: string;
    mediaFile?: Express.Multer.File;
    constructor({ senderId, type, text, mediaFile, }: {
        senderId: string;
        type: MessageType;
        text?: string;
        mediaFile?: Express.Multer.File;
    });
}
