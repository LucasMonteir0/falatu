import { Chat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
import { ChatUtils } from "../utils/chat.utils";

export class ChatEntity {
    id: string;
    title: string | null;
    pictureUrl: string | null;
    type: ChatType;
    createdAt: Date;
  
    constructor(
      id: string,
      type: ChatType,
      title: string | null,
      pictureUrl: string | null,
      createdAt: Date = new Date() 
    ) {
      this.id = id;
      this.type = type;
      this.title = title;
      this.pictureUrl = pictureUrl;
      this.createdAt = createdAt;
    }
  
    static fromPrisma(chat: Chat): ChatEntity {
      return new ChatEntity(chat.id, ChatUtils.fromValue(chat.type), chat.title, chat.picture_url, chat.createdAt);
    }
  }