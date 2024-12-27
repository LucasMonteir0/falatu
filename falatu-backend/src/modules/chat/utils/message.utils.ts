import { MessageType } from "../enums/message_type.enum";

export class MessageUtils {
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
  }