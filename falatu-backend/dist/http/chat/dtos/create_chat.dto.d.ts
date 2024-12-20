import { ChatType } from "../enums/chat_type.enum";
export declare class CreateChatDTO {
    title?: string;
    pictureUrl?: string;
    type: ChatType;
    usersIds: string[];
}
