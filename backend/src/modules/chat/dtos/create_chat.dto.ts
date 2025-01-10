import { ChatType } from "../enums/chat_type.enum";

export class CreateChatDTO {
    public title?: string;
    public pictureUrl?: string;
    public type: ChatType;
    public usersIds: string[];
}