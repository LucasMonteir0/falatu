import { ChatRole } from "../enums/chat_role.enum";
import { ChatType } from "../enums/chat_type.enum";

export class ChatUtils {
  static typeFromValue(value: string): ChatType {
    switch (value) {
      case "private":
        return ChatType.PRIVATE;
      case "group":
        return ChatType.GROUP;
      default:
        return ChatType.PRIVATE;
    }
  }

  static roleFromValue(value: string): ChatRole {
    switch (value) {
      case "admin":
        return ChatRole.ADMIN;
      case "member":
        return ChatRole.MEMBER;
      default:
        return ChatRole.MEMBER;
    }
  }


}
