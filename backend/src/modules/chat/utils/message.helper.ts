import { MessageEntity } from "../entities/message.entity";
import { MessageType } from "./enums/message_type.enum";

export class MessageHelper {
  static fromValue(value: string): MessageType {
    switch (value) {
      case "text":
        return MessageType.TEXT;
      case "audio":
        return MessageType.AUDIO;
      case "video":
        return MessageType.VIDEO;
      case "image":
        return MessageType.IMAGE;
      case "file":
        return MessageType.FILE;
      default:
        return MessageType.TEXT;
    }
  }

  static hasUserReads(messages: MessageEntity[], userId: string): boolean {
    return messages.some((message) =>
      message.messageReads.some((read) => read.user.id === userId)
    );
  }

  static handleFileMessageName(type: MessageType, originalName?: string) {
    if (type === MessageType.FILE) {
      return `${originalName}-fDTIME0:${new Date().toISOString()}`;
    }
    const typeName: string = type.toUpperCase();
    return `${typeName}:${new Date().toISOString()}`;
  }
}
