import { Message, MessageRead, User } from "@prisma/client";
import { MessageType } from "../enums/message_type.enum";
import { UserEntity } from "../../commons/entities/user.entity";
import { MessageUtils } from "../utils/message.utils";
import { MessageReadEntity } from "./message_read.entity";

export class MessageEntity {
  id: string;
  sender: UserEntity;
  type: MessageType;
  text?: string;
  mediaUrl?: string;
  createdAt: Date;
  messageReads: MessageReadEntity[];

  constructor({
    id,
    sender,
    type,
    createdAt,
    text,
    mediaUrl,
    messageReads,
  }: {
    id: string;
    sender: UserEntity;
    type: MessageType;
    createdAt: Date;
    text?: string;
    mediaUrl?: string;
    messageReads: MessageReadEntity[];
  }) {
    this.id = id;
    this.sender = sender;
    this.type = type;
    this.text = text;
    this.mediaUrl = mediaUrl;
    this.createdAt = createdAt;
    this.messageReads = messageReads;
  }

  static fromPrisma(
    message: Message & { messageReads: (MessageRead & { user: User })[] },
    sender: UserEntity,

  ): MessageEntity {
    return new MessageEntity({
      id: message.id,
      sender: sender,
      type: MessageUtils.fromValue(message.type),
      createdAt: message.createdAt,
      text: message.text,
      mediaUrl: message.media_url,
      messageReads: message.messageReads.map((e) =>
        MessageReadEntity.fromPrisma(e)
      ),
    });
  }
}
