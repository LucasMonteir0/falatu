import { Message } from "@prisma/client";
import { MessageType } from "../enums/message_type.enum";
import { UserEntity } from "src/modules/commons/entities/user.entity";
import { MessageUtils } from "../utils/message.utils";

export class MessageEntity {
  id: string;
  sender: UserEntity;
  type: MessageType;
  text?: string;
  mediaUrl?: string;
  createdAt: Date;

  constructor({
    id,
    sender,
    type,
    createdAt,
    text,
    mediaUrl,
  }: {
    id: string;
    sender: UserEntity;
    type: MessageType;
    createdAt: Date;
    text?: string;
    mediaUrl?: string;
  }) {
    this.id = id;
    this.sender = sender;
    this.type = type;
    this.text = text;
    this.mediaUrl = mediaUrl;
    this.createdAt = createdAt;
  }

  static fromPrisma(message: Message, sender: UserEntity): MessageEntity {return new MessageEntity({
    id: message.id,
    sender: sender,
    type: MessageUtils.fromValue(message.type),
    createdAt: message.createdAt,
    text: message.text,
    mediaUrl: message.media_url,
  })};
}
