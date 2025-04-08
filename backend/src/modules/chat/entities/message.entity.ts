import { Message, MessageRead, User } from "@prisma/client";
import { MessageType } from "../utils/enums/message_type.enum";
import { UserEntity } from "../../commons/entities/user.entity";
import { MessageHelper } from "../utils/message.helper";
import { MessageReadEntity } from "./message_read.entity";

export type MessageEntityParams = {
  id: string;
  sender: UserEntity;
  type: MessageType;
  createdAt: Date;
  text?: string;
  mediaUrl?: string;
  thumbUrl?: string;
  messageReads: MessageReadEntity[];
};

export class MessageEntity {
  id: string;
  sender: UserEntity;
  type: MessageType;
  text?: string;
  mediaUrl?: string;
  thumbUrl?: string;
  createdAt: Date;
  messageReads: MessageReadEntity[];

  constructor(params: MessageEntityParams) {
    this.id = params.id;
    this.sender = params.sender;
    this.type = params.type;
    this.text = params.text;
    this.mediaUrl = params.mediaUrl;
    this.thumbUrl = params.thumbUrl;
    this.createdAt = params.createdAt;
    this.messageReads = params.messageReads;
  }

  static fromPrisma(
    message: Message & {
      messageReads: (MessageRead & { user: User })[];
      sender: User;
    }
  ): MessageEntity {
    return new MessageEntity({
      id: message.id,
      sender: UserEntity.fromPrisma(message.sender),
      type: MessageHelper.fromValue(message.type),
      createdAt: message.createdAt,
      text: message.text,
      mediaUrl: message.media_url,
      thumbUrl: message.thumb_url,
      messageReads: message.messageReads.map((e) =>
        MessageReadEntity.fromPrisma(e)
      ),
    });
  }
}
