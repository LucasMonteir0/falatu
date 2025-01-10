"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessageEntity = void 0;
const message_utils_1 = require("../utils/message.utils");
class MessageEntity {
    constructor({ id, sender, type, createdAt, text, mediaUrl, }) {
        this.id = id;
        this.sender = sender;
        this.type = type;
        this.text = text;
        this.mediaUrl = mediaUrl;
        this.createdAt = createdAt;
    }
    static fromPrisma(message, sender) {
        return new MessageEntity({
            id: message.id,
            sender: sender,
            type: message_utils_1.MessageUtils.fromValue(message.type),
            createdAt: message.createdAt,
            text: message.text,
            mediaUrl: message.media_url,
        });
    }
    ;
}
exports.MessageEntity = MessageEntity;
//# sourceMappingURL=message.entity.js.map