"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatEntity = void 0;
const chat_utils_1 = require("../utils/chat.utils");
class ChatEntity {
    constructor(id, type, title, pictureUrl, users, createdAt = new Date()) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.pictureUrl = pictureUrl;
        this.users = users;
        this.createdAt = createdAt;
    }
    static fromPrisma(chat, users) {
        return new ChatEntity(chat.id, chat_utils_1.ChatUtils.fromValue(chat.type), chat.title, chat.picture_url, users, chat.createdAt);
    }
}
exports.ChatEntity = ChatEntity;
//# sourceMappingURL=chat.entity.js.map