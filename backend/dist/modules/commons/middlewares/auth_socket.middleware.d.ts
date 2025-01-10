import { JwtService } from "@nestjs/jwt";
import { Socket } from "socket.io";
import { PrismaService } from "src/utils/config/database/prisma.service";
type SocketMiddleware = (socket: Socket, next: (err?: Error) => void) => void;
export declare const AuthSocketMiddleware: (jwtService: JwtService, primsaService: PrismaService) => SocketMiddleware;
export {};
