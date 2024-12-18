import { User } from "@prisma/client";
export declare class UserEntity {
    id: string;
    name: string;
    email: string;
    pictureUrl: string | null;
    createdAt: Date;
    constructor(id: string, name: string, email: string, pictureUrl: string | null, createdAt?: Date);
    static fromPrisma(user: User): UserEntity;
}
