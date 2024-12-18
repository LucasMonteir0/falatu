"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatUtils = void 0;
const chat_type_enum_1 = require("../enums/chat_type.enum");
class ChatUtils {
    static fromValue(value) {
        switch (value) {
            case "private":
                return chat_type_enum_1.ChatType.PRIVATE;
            case "group":
                return chat_type_enum_1.ChatType.GROUP;
            default:
                return chat_type_enum_1.ChatType.PRIVATE;
        }
    }
}
exports.ChatUtils = ChatUtils;
//# sourceMappingURL=chat.utils.js.map