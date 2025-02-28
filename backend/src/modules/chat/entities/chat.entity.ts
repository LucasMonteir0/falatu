import { Chat, Message, MessageRead, User, UserChat } from "@prisma/client";
import { ChatType } from "../enums/chat_type.enum";
import { ChatUtils } from "../utils/chat.utils";
import { ChatUserEntity } from "./chat_user.entity";
import { MessageEntity } from "./message.entity";

export class ChatEntity {
  id: string;
  title: string | null;
  pictureUrl?: string | null;
  type: ChatType;
  createdAt: Date;
  users: ChatUserEntity[];
  lastMessage: MessageEntity | null;
  unreadCount: number;

  constructor(
    id: string,
    type: ChatType,
    title: string | null,
    pictureUrl: string | null,
    users: ChatUserEntity[],
    lastMessage: MessageEntity | null,
    unreadCount: number = 0,
    createdAt: Date = new Date()
  ) {
    this.id = id;
    this.type = type;
    this.title = title;
    this.pictureUrl = pictureUrl;
    this.users = users;
    this.lastMessage = lastMessage;
    this.unreadCount = unreadCount;
    this.createdAt = createdAt;
  }

  static fromPrisma(
    chat: Chat & {
      userChats: (UserChat & { user: User })[];
      lastMessage?:
        | (Message & {
            messageReads: (MessageRead & { user: User })[];
            sender: User;
          })
        | null;
    },
    unreadCount?: number
  ): ChatEntity {
    return new ChatEntity(
      chat.id,
      ChatUtils.typeFromValue(chat.type),
      chat.title,
      chat.picture_url,
      chat.userChats.map((e) =>
        ChatUserEntity.fromPrisma(e.user, ChatUtils.roleFromValue(e.role))
      ),
      chat.lastMessage ? MessageEntity.fromPrisma(chat.lastMessage) : null,
      unreadCount,
      chat.createdAt
    );
  }
}
