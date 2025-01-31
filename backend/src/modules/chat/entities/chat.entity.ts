import { Chat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
import { ChatUtils } from "../utils/chat.utils";
import { ChatUserEntity } from "./chat_user.entity";

export class ChatEntity {
  id: string;
  title: string | null;
  pictureUrl?: string | null;
  type: ChatType;
  createdAt: Date;
  users: ChatUserEntity[];

  constructor(
    id: string,
    type: ChatType,
    title: string | null,
    pictureUrl: string | null,
    users: ChatUserEntity[],
    createdAt: Date = new Date()
  ) {
    this.id = id;
    this.type = type;
    this.title = title;
    this.pictureUrl = pictureUrl;
    this.users = users;
    this.createdAt = createdAt;
  }

  static fromPrisma(chat: Chat, users: ChatUserEntity[]): ChatEntity {
    return new ChatEntity(
      chat.id,
      ChatUtils.typeFromValue(chat.type),
      chat.title,
      chat.picture_url,
      users,
      chat.createdAt
    );
  }
}
