import { Chat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
import { ChatUtils } from "../utils/chat.utils";
import { UserEntity } from "src/http/commons/entities/user.entity";

export class ChatEntity {
  id: string;
  title: string | null;
  pictureUrl?: string | null;
  type: ChatType;
  createdAt: Date;
  users: UserEntity[];

  constructor(
    id: string,
    type: ChatType,
    title: string | null,
    pictureUrl: string | null,
    users: UserEntity[],
    createdAt: Date = new Date()
  ) {
    this.id = id;
    this.type = type;
    this.title = title;
    this.pictureUrl = pictureUrl;
    this.users = users;
    this.createdAt = createdAt;
  }

  static fromPrisma(chat: Chat, users: UserEntity[]): ChatEntity {
    return new ChatEntity(
      chat.id,
      ChatUtils.fromValue(chat.type),
      chat.title,
      chat.picture_url,
      users,
      chat.createdAt
    );
  }
}
