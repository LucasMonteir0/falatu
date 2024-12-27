import { OnGatewayConnection, OnGatewayDisconnect, OnGatewayInit } from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { MessageDatasource } from "../datasources/message/message.datasource";
import { SendMessageDto } from "../dtos/send_message.dto";
import { JwtService } from "@nestjs/jwt";
import { PrismaService } from "src/utils/config/database/prisma.service";
export declare class MessagesGateway implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
    private readonly datasource;
    private readonly jwtService;
    private readonly prismaService;
    constructor(datasource: MessageDatasource, jwtService: JwtService, prismaService: PrismaService);
    server: Server;
    private chatId?;
    afterInit(): Promise<void>;
    handleConnection(client: Socket, ...args: any[]): Promise<void>;
    handleDisconnect(client: Socket): void;
    handleJoinRoom(client: Socket, message: SendMessageDto): Promise<void>;
}
