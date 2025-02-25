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
import { CreateMessageDto } from "../dtos/create_message_dto";

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
    await this.emitMessagesToChat(this.server, chatId, 1);
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
    @MessageBody()
    data: { message: CreateMessageDto; chatId: string }
  ) {
    const { chatId, message } = data;
    if (!chatId || !message) {
      return new BadRequestError("chatId and message are required.");
    }

    const newMessage = await this.datasource.create(message, chatId);
    if (newMessage.isSuccess) {
      await this.emitMessagesToChat(this.server, chatId);
    } else {
      return newMessage.error;
    }
  }

  @SubscribeMessage("addOldMessages")
  async handleAddOldMessages(
    @ConnectedSocket() client: Socket,
    @MessageBody()
    data: { message: CreateMessageDto; chatId: string; page: number }
  ) {
    const { chatId, page } = data;
    if (!chatId || !page) {
      return new BadRequestError("chatId and message are required.");
    }

    return this.emitMessagesToChat(this.server, chatId, page);
  }

  private async emitMessagesToChat(
    client: Socket | Server,
    chatId: string,
    page?: number
  ) {
    let allMessages = [];

    for (let i = 1; i <= page; i++) {
      const messages = await this.datasource.getByChat(chatId, i);
      if (messages.isSuccess) {
        allMessages = [...messages.data, ...allMessages]; // Adiciona mensagens na ordem correta (mais antigas primeiro)
      } else {
        return messages.error;
      }
    }

    client.to(chatId).emit("messages", allMessages);
  }

  private async leaveChatRoom(client: Socket, chatId: string) {
    if (client.rooms.has(chatId)) {
      client.leave(chatId);
    }
  }
}
