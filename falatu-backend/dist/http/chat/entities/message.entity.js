"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessageEntity = void 0;
class MessageEntity {
    constructor(id, content, senderId, type, createdAt, message, mediaUrl) {
        this.id = id;
        this.content = content;
        this.senderId = senderId;
        this.type = type;
        this.message = message;
        this.mediaUrl = mediaUrl;
        this.createdAt = createdAt;
    }
}
exports.MessageEntity = MessageEntity;
//# sourceMappingURL=message.entity.js.map