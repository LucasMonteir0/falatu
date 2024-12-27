import { ChatRole } from "../enums/chat_role.enum";
import { ChatType } from "../enums/chat_type.enum";
export declare class ChatUtils {
    static typeFromValue(value: string): ChatType;
    static roleFromValue(value: string): ChatRole;
}
