import { MessageRead, User } from "@prisma/client";
import { UserEntity } from "../../commons/entities/user.entity";

export class MessageReadEntity {
  id: string;
  user: UserEntity;
  readAt: Date;

  constructor({
    id,
    user,
    readAt,
  }: {
    id: string;
    user: UserEntity;
    readAt: Date;
  }) {
    this.id = id;
    this.user = user;
    this.readAt = readAt;
  }

  static fromPrisma(read: MessageRead & {user: User}): MessageReadEntity {
    return new MessageReadEntity({
      id: `${read.messageId}:${read.userId}`,
      user: UserEntity.fromPrisma(read.user),
      readAt: read.readAt,
    });
  }
}
