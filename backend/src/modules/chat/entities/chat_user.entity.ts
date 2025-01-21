import { UserEntity } from "../../commons/entities/user.entity";
import { ChatRole } from "../enums/chat_role.enum";
import { User } from "@prisma/client";

export class ChatUserEntity {
  user: UserEntity;
  role: ChatRole;

  constructor(user: UserEntity, role: ChatRole) {
    this.user = user;
    this.role = role;
  }

  static fromPrisma(user: User, role: ChatRole): ChatUserEntity {
    return new ChatUserEntity(UserEntity.fromPrisma(user), role);
  }
}
