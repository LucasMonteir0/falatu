"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatUtils = void 0;
const chat_role_enum_1 = require("../enums/chat_role.enum");
const chat_type_enum_1 = require("../enums/chat_type.enum");
class ChatUtils {
    static typeFromValue(value) {
        switch (value) {
            case "private":
                return chat_type_enum_1.ChatType.PRIVATE;
            case "group":
                return chat_type_enum_1.ChatType.GROUP;
            default:
                return chat_type_enum_1.ChatType.PRIVATE;
        }
    }
    static roleFromValue(value) {
        switch (value) {
            case "admin":
                return chat_role_enum_1.ChatRole.ADMIN;
            case "member":
                return chat_role_enum_1.ChatRole.MEMBER;
            default:
                return chat_role_enum_1.ChatRole.MEMBER;
        }
    }
}
exports.ChatUtils = ChatUtils;
//# sourceMappingURL=chat.utils.js.map