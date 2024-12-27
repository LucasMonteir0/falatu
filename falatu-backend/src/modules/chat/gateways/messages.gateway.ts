import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  ConnectedSocket,
  OnGatewayConnection,
  OnGatewayDisconnect,
  MessageBody,
  OnGatewayInit,
} from "@nestjs/websockets";
import { Server, Socket } from "socket.io";
import { BadRequestError } from "src/utils/result/AppError";
import { MessageDatasource } from "../datasources/message/message.datasource";
import { SendMessageDto } from "../dtos/send_message.dto";
import { JwtService } from "@nestjs/jwt";
import { AuthSocketMiddleware } from "src/modules/commons/middlewares/auth_socket.middleware";
import { PrismaService } from "src/utils/config/database/prisma.service";

@WebSocketGateway(80, {
  namespace: "/messages",
})
export class MessagesGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor(
    private readonly datasource: MessageDatasource,
    private readonly jwtService: JwtService,
    private readonly prismaService: PrismaService
  ) {}

  @WebSocketServer()
  server: Server;

  private chatId?: string = null;

  async afterInit() {
    this.server.use(AuthSocketMiddleware(this.jwtService, this.prismaService));
  }

  async handleConnection(client: Socket, ...args: any[]) {
    this.chatId = client.handshake.query.chatId as string;
    await client.join(this.chatId);
    if (!this.chatId) {
      client.disconnect();
      throw new BadRequestError("User id must be provided.");
    }

    const messages = await this.datasource.getMessagesByChatId(this.chatId);

    client.emit("messages", messages.data);
  }

  handleDisconnect(client: Socket) {
    client.leave(this.chatId);
  }

  @SubscribeMessage("sendMessage")
  async handleJoinRoom(
    @ConnectedSocket() client: Socket,
    @MessageBody("message") message: SendMessageDto
  ) {
    const chatId = client.handshake.query.chatId as string;
    if (message) {
      const newMessage = await this.datasource.sendMessage(message, chatId);
      if (newMessage.isSuccess) {
        this.server.emit("messages", newMessage.data);
      } else {
        throw newMessage.error;
      }
    }
  }
}
