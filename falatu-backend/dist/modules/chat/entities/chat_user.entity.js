"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatUserEntity = void 0;
const user_entity_1 = require("../../commons/entities/user.entity");
class ChatUserEntity {
    constructor(user, role) {
        this.user = user;
        this.role = role;
    }
    static fromPrisma(user, role) {
        return new ChatUserEntity(user_entity_1.UserEntity.fromPrisma(user), role);
    }
}
exports.ChatUserEntity = ChatUserEntity;
//# sourceMappingURL=chat_user.entity.js.map