"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessageUtils = void 0;
const message_type_enum_1 = require("../enums/message_type.enum");
class MessageUtils {
    static fromValue(value) {
        switch (value) {
            case "text":
                return message_type_enum_1.MessageType.TEXT;
            case "audio":
                return message_type_enum_1.MessageType.AUDIO;
            case "video":
                return message_type_enum_1.MessageType.VIDEO;
            case "image":
                return message_type_enum_1.MessageType.IMAGE;
            case "file":
                return message_type_enum_1.MessageType.FILE;
            default:
                return message_type_enum_1.MessageType.TEXT;
        }
    }
}
exports.MessageUtils = MessageUtils;
//# sourceMappingURL=message.utils.js.map