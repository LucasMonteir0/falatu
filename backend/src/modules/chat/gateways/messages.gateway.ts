import { JwtService } from "@nestjs/jwt";
import {
  WebSocketGateway,
  OnGatewayInit,
  WebSocketServer,
  SubscribeMessage,
  ConnectedSocket,
  MessageBody,
  OnGatewayDisconnect,
  OnGatewayConnection,
} from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { AuthSocketMiddleware } from "src/modules/commons/middlewares/auth_socket.middleware";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { BadRequestError } from "src/utils/result/AppError";
import { MessageDatasource } from "../datasources/message/message.datasource";
import { SendMessageDto } from "../dtos/send_message.dto";

@WebSocketGateway(81, { namespace: "/messages" })
export class MessageGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor(
    private readonly datasource: MessageDatasource,
    private readonly jwtService: JwtService,
    private readonly prismaService: PrismaService
  ) {}

  @WebSocketServer()
  server: Server;

  async afterInit() {
    this.server.use(AuthSocketMiddleware(this.jwtService, this.prismaService));
  }

  async handleConnection(client: Socket) {
    const userId = client.handshake.query.userId as string;
    const chatId = client.handshake.query.chatId as string;

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

  async handleDisconnect(client: Socket) {
    const userId = client.handshake.query.userId as string;
    const chatId = client.handshake.query.chatId as string;
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
      await this.emitMessagesToChat(client, chatId);
    } else {
      return newMessage.error;
    }
  }

  private async emitMessagesToChat(client: Socket | Server, chatId: string) {
    const messages = await this.datasource.getMessagesByChatId(chatId);
    if (messages.isSuccess) {
      client.to(chatId).emit("messages", messages.data);
    }
    return messages.error;
  }

  private async leaveChatRoom(client: Socket, chatId: string) {
    if (client.rooms.has(chatId)) {
      client.leave(chatId);
    }
  }
}
