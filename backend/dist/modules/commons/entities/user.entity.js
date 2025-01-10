"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserEntity = void 0;
class UserEntity {
    constructor(id, name, email, pictureUrl, createdAt = new Date()) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.pictureUrl = pictureUrl;
        this.createdAt = createdAt;
    }
    static fromPrisma(user) {
        return new UserEntity(user.id, user.name, user.email, user.picture_url, user.createdAt);
    }
}
exports.UserEntity = UserEntity;
//# sourceMappingURL=user.entity.js.map