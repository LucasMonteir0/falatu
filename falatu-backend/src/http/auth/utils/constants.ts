import { SetMetadata } from "@nestjs/common";

export const jwtSecret = "welkqwpoekpqwoke qpo ekoqp";
export const IS_PUBLIC_KEY = "isPublic";
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);
