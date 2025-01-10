import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
} from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { BadRequestError } from "src/utils/result/AppError";
import { ChatDatasource } from "../datasources/chat/chat.datasource";
import { MessageDatasource } from "../datasources/message/message.datasource";
import { JwtService } from "@nestjs/jwt";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { AuthSocketMiddleware } from "src/modules/commons/middlewares/auth_socket.middleware";
import { SendMessageDto } from "../dtos/send_message.dto";

@WebSocketGateway(80, { namespace: "/chats" })
export class ChatGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor(
    private readonly datasource: MessageDatasource,
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
  }

  async handleDisconnect(client: Socket) {
    const userId = client.handshake.query.userId as string;
    const sockets = this.userSockets.get(userId);
    if (sockets) {
      sockets.delete(client);
      if (sockets.size === 0) this.userSockets.delete(userId);
    }
  }

  @SubscribeMessage("openChat")
  async handleJoinChat(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { chatId: string }
  ) {
    const userId = client.handshake.query.userId as string;

    const { chatId } = data;

    if (!chatId || !userId) {
      throw new BadRequestError(
        "chatId and userId is required to open a chat."
      );
    }

    await client.join(chatId);
    client.emit("joinedChat", {
      chatId,
      userId,
      message: "User joined this chat.",
    });
    await this.emitMessagesToChat(this.server, chatId);
  }

  @SubscribeMessage("leaveChat")
  async handleLeaveChat(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { chatId: string }
  ) {
    const userId = client.handshake.query.userId as string;
    const { chatId } = data;
    if (!chatId || !userId) {
      throw new BadRequestError(
        "chatId and userId is required to leave a chat."
      );
    }

    await this.leaveChatRoom(client, chatId);
    client.emit("leftChat", {
      chatId,
      userId,
      message: "User left this chat.",
    });
  }

  @SubscribeMessage("sendMessage")
  async handleSendMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { message: SendMessageDto; chatId: string }
  ) {
    const { chatId, message } = data;

    if (!chatId || !message) {
      return new BadRequestError("chatId and message are required.");
    }

    const newMessage = await this.datasource.sendMessage(message, chatId);
    if (newMessage.isSuccess) {
      await this.emitMessagesToChat(this.server, chatId);

      const participants = await this.chatDatasource.getUsersByChatId(chatId);
      participants.data.forEach((participant) => {
        this.emitChatsToUser(participant.user.id);
      });
    } else {
      return newMessage.error;
    }
  }

  private async emitMessagesToChat(client: Socket | Server, chatId: string) {
    const messages = await this.datasource.getMessagesByChatId(chatId);
    client.to(chatId).emit("messages", messages.data);
  }

  private async emitChatsToUser(userId: string) {
    const sockets = this.userSockets.get(userId);
    if (!sockets) return;

    const chats = await this.chatDatasource.getChatsByUserId(userId);
    sockets.forEach((socket) => {
      socket.emit("chats", chats.data);
    });
  }

  private async leaveChatRoom(client: Socket, chatId: string) {
    if (client.rooms.has(chatId)) {
      client.leave(chatId);
    }
  }
}
