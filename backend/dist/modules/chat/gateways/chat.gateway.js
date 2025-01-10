"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
const AppError_1 = require("../../../utils/result/AppError");
const chat_datasource_1 = require("../datasources/chat/chat.datasource");
const message_datasource_1 = require("../datasources/message/message.datasource");
const jwt_1 = require("@nestjs/jwt");
const prisma_service_1 = require("../../../utils/config/database/prisma.service");
const auth_socket_middleware_1 = require("../../commons/middlewares/auth_socket.middleware");
let ChatGateway = class ChatGateway {
    constructor(datasource, chatDatasource, jwtService, prismaService) {
        this.datasource = datasource;
        this.chatDatasource = chatDatasource;
        this.jwtService = jwtService;
        this.prismaService = prismaService;
        this.userSockets = new Map();
    }
    async afterInit() {
        this.server.use((0, auth_socket_middleware_1.AuthSocketMiddleware)(this.jwtService, this.prismaService));
    }
    async handleConnection(client) {
        const userId = client.handshake.query.userId;
        if (!userId) {
            client.disconnect();
            throw new AppError_1.BadRequestError("userId must be provided.");
        }
        const sockets = this.userSockets.get(userId) || new Set();
        sockets.add(client);
        this.userSockets.set(userId, sockets);
    }
    async handleDisconnect(client) {
        const userId = client.handshake.query.userId;
        const sockets = this.userSockets.get(userId);
        if (sockets) {
            sockets.delete(client);
            if (sockets.size === 0)
                this.userSockets.delete(userId);
        }
    }
    async handleJoinChat(client, data) {
        const userId = client.handshake.query.userId;
        const { chatId } = data;
        if (!chatId || !userId) {
            throw new AppError_1.BadRequestError("chatId and userId is required to open a chat.");
        }
        await client.join(chatId);
        client.emit("joinedChat", {
            chatId,
            userId,
            message: "User joined this chat.",
        });
        await this.emitMessagesToChat(this.server, chatId);
    }
    async handleLeaveChat(client, data) {
        const userId = client.handshake.query.userId;
        const { chatId } = data;
        if (!chatId || !userId) {
            throw new AppError_1.BadRequestError("chatId and userId is required to leave a chat.");
        }
        await this.leaveChatRoom(client, chatId);
        client.emit("leftChat", {
            chatId,
            userId,
            message: "User left this chat.",
        });
    }
    async handleSendMessage(client, data) {
        const { chatId, message } = data;
        if (!chatId || !message) {
            return new AppError_1.BadRequestError("chatId and message are required.");
        }
        const newMessage = await this.datasource.sendMessage(message, chatId);
        if (newMessage.isSuccess) {
            await this.emitMessagesToChat(this.server, chatId);
            const participants = await this.chatDatasource.getUsersByChatId(chatId);
            participants.data.forEach((participant) => {
                this.emitChatsToUser(participant.user.id);
            });
        }
        else {
            return newMessage.error;
        }
    }
    async emitMessagesToChat(client, chatId) {
        const messages = await this.datasource.getMessagesByChatId(chatId);
        client.to(chatId).emit("messages", messages.data);
    }
    async emitChatsToUser(userId) {
        const sockets = this.userSockets.get(userId);
        if (!sockets)
            return;
        const chats = await this.chatDatasource.getChatsByUserId(userId);
        sockets.forEach((socket) => {
            socket.emit("chats", chats.data);
        });
    }
    async leaveChatRoom(client, chatId) {
        if (client.rooms.has(chatId)) {
            client.leave(chatId);
        }
    }
};
exports.ChatGateway = ChatGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], ChatGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)("openChat"),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleJoinChat", null);
__decorate([
    (0, websockets_1.SubscribeMessage)("leaveChat"),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleLeaveChat", null);
__decorate([
    (0, websockets_1.SubscribeMessage)("sendMessage"),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleSendMessage", null);
exports.ChatGateway = ChatGateway = __decorate([
    (0, websockets_1.WebSocketGateway)(80, { namespace: "/chats" }),
    __metadata("design:paramtypes", [message_datasource_1.MessageDatasource,
        chat_datasource_1.ChatDatasource,
        jwt_1.JwtService,
        prisma_service_1.PrismaService])
], ChatGateway);
//# sourceMappingURL=chat.gateway.js.map