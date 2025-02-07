import { ChatRole } from "../enums/chat_role.enum";
import { User } from "@prisma/client";

export class ChatUserEntity {
  id: string;
  name: string;
  email: string;
  role: ChatRole;
  pictureUrl?: string;
  createdAt: Date;

  constructor(
    id: string,
    name: string,
    email: string,
    role: ChatRole,
    pictureUrl?: string,
    createdAt: Date = new Date()
  ) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.pictureUrl = pictureUrl;
    this.createdAt = createdAt;
    this.role = role;
  }

  static fromPrisma(user: User, role: ChatRole): ChatUserEntity {
    return new ChatUserEntity(
      user.id,
      user.name,
      user.email,
      role,
      user.picture_url,
      user.createdAt
    );
  }
}
