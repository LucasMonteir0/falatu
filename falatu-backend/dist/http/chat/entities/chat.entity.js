"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatEntity = void 0;
const chat_utils_1 = require("../utils/chat.utils");
class ChatEntity {
    constructor(id, type, title, pictureUrl, createdAt = new Date()) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.pictureUrl = pictureUrl;
        this.createdAt = createdAt;
    }
    static fromPrisma(chat) {
        return new ChatEntity(chat.id, chat_utils_1.ChatUtils.fromValue(chat.type), chat.title, chat.picture_url, chat.createdAt);
    }
}
exports.ChatEntity = ChatEntity;
//# sourceMappingURL=chat.entity.js.map