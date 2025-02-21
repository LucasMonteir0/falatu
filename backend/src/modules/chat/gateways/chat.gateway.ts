import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  MessageBody,
  SubscribeMessage,
} from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { BadRequestError } from "src/utils/result/AppError";
import { ChatDatasource } from "../datasources/chat/chat.datasource";
import { JwtService } from "@nestjs/jwt";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { AuthSocketMiddleware } from "src/modules/commons/middlewares/auth_socket.middleware";
import { CreateChatDTO } from "../dtos/create_chat.dto";

@WebSocketGateway(80, { namespace: "/chats" })
export class ChatGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor(
    private readonly chatDatasource: ChatDatasource,
    private readonly jwtService: JwtService,
    private readonly prismaService: PrismaService
  ) {}

  private readonly userSockets = new Map<string, Set<Socket>>();

  @WebSocketServer()
  server: Server;

  async afterInit() {
    this.server.use(AuthSocketMiddleware(this.jwtService, this.prismaService));
  }

  async handleConnection(client: Socket) {
    const userId = client.handshake.query.userId as string;
    if (!userId) {
      client.disconnect();
      throw new BadRequestError("userId must be provided.");
    }

    const sockets = this.userSockets.get(userId) || new Set();
    sockets.add(client);
    this.userSockets.set(userId, sockets);
    this.emitChatsToUsers([userId]);
  }

  async handleDisconnect(client: Socket) {
    const userId = client.handshake.query.userId as string;
    const sockets = this.userSockets.get(userId);
    if (sockets) {
      sockets.delete(client);
      if (sockets.size === 0) this.userSockets.delete(userId);
    }
  }

  async createChat(client: Socket, @MessageBody() data: CreateChatDTO) {
    const result = await this.chatDatasource.createChat(data);
    if (result.isSuccess) {
      const ids = result.data.users.map((e) => e.id);
      this.emitChatsToUsers(ids);
    }
  }
  
  @SubscribeMessage("updateLastMessage")
  async updateLastMessage(
    client: Socket,
    @MessageBody() data: { chatId: string; messageId: string }
  ) {
    const { chatId, messageId } = data;
    if (!chatId || !messageId) {
      return new BadRequestError("chatId and messageId are required.");
    }
    const result = await this.chatDatasource.updateLastMessage(
      chatId,
      messageId
    );
    if (result.isSuccess) {
      const ids = result.data.users.map((e) => e.id);
      this.emitChatsToUsers(ids);
    }
  }

  private async emitChatsToUsers(usersIds: string[]) {
    for (const id of usersIds) {
      const sockets = this.userSockets.get(id);
      if (!sockets) return;

      const chats = await this.chatDatasource.getChatsByUserId(id);
      sockets.forEach((socket) => {
        socket.emit("chats", chats.data);
      });
    }
  }
}
