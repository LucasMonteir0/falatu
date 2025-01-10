import { OnGatewayConnection, OnGatewayDisconnect, OnGatewayInit } from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { ChatDatasource } from "../datasources/chat/chat.datasource";
import { MessageDatasource } from "../datasources/message/message.datasource";
import { JwtService } from "@nestjs/jwt";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { SendMessageDto } from "../dtos/send_message.dto";
export declare class ChatGateway implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
    private readonly datasource;
    private readonly chatDatasource;
    private readonly jwtService;
    private readonly prismaService;
    constructor(datasource: MessageDatasource, chatDatasource: ChatDatasource, jwtService: JwtService, prismaService: PrismaService);
    private readonly userSockets;
    server: Server;
    afterInit(): Promise<void>;
    handleConnection(client: Socket): Promise<void>;
    handleDisconnect(client: Socket): Promise<void>;
    handleJoinChat(client: Socket, data: {
        chatId: string;
    }): Promise<void>;
    handleLeaveChat(client: Socket, data: {
        chatId: string;
    }): Promise<void>;
    handleSendMessage(client: Socket, data: {
        message: SendMessageDto;
        chatId: string;
    }): Promise<import("src/utils/result/AppError").AppError>;
    private emitMessagesToChat;
    private emitChatsToUser;
    private leaveChatRoom;
}
