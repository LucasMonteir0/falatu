import { OnGatewayConnection, OnGatewayDisconnect } from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { BadRequestError } from "src/utils/result/AppError";
import { ChatDatasource } from "../datasources/chat/chat.datasource";
export declare class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
    private readonly datasource;
    constructor(datasource: ChatDatasource);
    handleConnection(client: Socket, ...args: any[]): BadRequestError;
    handleDisconnect(client: Socket): void;
    server: Server;
    handleJoinRoom(client: Socket): Promise<void>;
}
