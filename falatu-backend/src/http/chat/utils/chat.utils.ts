import { ChatType } from "../enums/chat_type.enum";

export class ChatUtils {
    static fromValue(value: string): ChatType {
      switch (value) {
        case "private":
          return ChatType.PRIVATE;
        case "group":
          return ChatType.GROUP;
        default:
          return ChatType.PRIVATE;
      }
    }
  }