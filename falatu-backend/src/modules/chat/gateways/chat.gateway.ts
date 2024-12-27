import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { BadRequestError } from "src/utils/result/AppError";
import { ChatDatasource } from "../datasources/chat/chat.datasource";

@WebSocketGateway(80, {
  namespace: "/chat",
})
export class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
  constructor(private readonly datasource: ChatDatasource) {}

  handleConnection(client: Socket, ...args: any[]) {
    const userId = client.handshake.query.userId;
    if (!userId) {
      client.disconnect();
      return new BadRequestError("User id must be provided.");
    }
  }

  handleDisconnect(client: Socket) {}

  @WebSocketServer()
  server: Server;

  @SubscribeMessage("loadChats")
  async handleJoinRoom(@ConnectedSocket() client: Socket) {
    const userId = client.handshake.query.userId as string;
    console.log(userId);
    const chats = await this.datasource.getChatsByUser(userId);
    if (chats.isSuccess) {
      this.server.emit("load-chats", { chats: chats.data });
    }
  }
}
