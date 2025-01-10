import { User } from "@prisma/client";

export class UserEntity {
  id: string;
  name: string;
  email: string;
  pictureUrl?: string;
  createdAt: Date;

  constructor(
    id: string,
    name: string,
    email: string,
    pictureUrl?: string ,
    createdAt: Date = new Date()
  ) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.pictureUrl = pictureUrl;
    this.createdAt = createdAt;
  }

  static fromPrisma(user: User): UserEntity {
    return new UserEntity(user.id,user.name, user.email, user.picture_url, user.createdAt);
  }
}