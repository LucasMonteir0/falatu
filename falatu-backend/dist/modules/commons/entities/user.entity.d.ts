import { User } from "@prisma/client";
export declare class UserEntity {
    id: string;
    name: string;
    email: string;
    pictureUrl?: string;
    createdAt: Date;
    constructor(id: string, name: string, email: string, pictureUrl?: string, createdAt?: Date);
    static fromPrisma(user: User): UserEntity;
}
