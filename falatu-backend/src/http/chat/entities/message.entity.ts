import { MessageType } from "../enums/message_type.enum";

export class MessageEntity {
  id: string;
  content: string;
  senderId: string;
  type: MessageType;
  message: string | null;
  mediaUrl: string | null;
  createdAt: Date;

  constructor(
    id: string,
    content: string,
    senderId: string,
    type: MessageType,
    createdAt: Date,
    message: string | null,
    mediaUrl: string | null
  ) {
    this.id = id;
    this.content = content;
    this.senderId = senderId;
    this.type = type;
    this.message = message;
    this.mediaUrl = mediaUrl;
    this.createdAt = createdAt;
  }
}
