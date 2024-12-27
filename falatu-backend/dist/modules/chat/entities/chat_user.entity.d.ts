import { UserEntity } from "src/modules/commons/entities/user.entity";
import { ChatRole } from "../enums/chat_role.enum";
import { User } from "@prisma/client";
export declare class ChatUserEntity {
    user: UserEntity;
    role: ChatRole;
    constructor(user: UserEntity, role: ChatRole);
    static fromPrisma(user: User, role: ChatRole): ChatUserEntity;
}
