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
exports.MessagesGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
const AppError_1 = require("../../../utils/result/AppError");
const message_datasource_1 = require("../datasources/message/message.datasource");
const send_message_dto_1 = require("../dtos/send_message.dto");
const jwt_1 = require("@nestjs/jwt");
const auth_socket_middleware_1 = require("../../commons/middlewares/auth_socket.middleware");
const prisma_service_1 = require("../../../utils/config/database/prisma.service");
let MessagesGateway = class MessagesGateway {
    constructor(datasource, jwtService, prismaService) {
        this.datasource = datasource;
        this.jwtService = jwtService;
        this.prismaService = prismaService;
        this.chatId = null;
    }
    async afterInit() {
        this.server.use((0, auth_socket_middleware_1.AuthSocketMiddleware)(this.jwtService, this.prismaService));
    }
    async handleConnection(client, ...args) {
        this.chatId = client.handshake.query.chatId;
        await client.join(this.chatId);
        if (!this.chatId) {
            client.disconnect();
            throw new AppError_1.BadRequestError("User id must be provided.");
        }
        const messages = await this.datasource.getMessagesByChatId(this.chatId);
        client.emit("messages", messages.data);
    }
    handleDisconnect(client) {
        client.leave(this.chatId);
    }
    async handleJoinRoom(client, message) {
        const chatId = client.handshake.query.chatId;
        if (message) {
            const newMessage = await this.datasource.sendMessage(message, chatId);
            if (newMessage.isSuccess) {
                this.server.emit("messages", newMessage.data);
            }
            else {
                throw newMessage.error;
            }
        }
    }
};
exports.MessagesGateway = MessagesGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], MessagesGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)("sendMessage"),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)("message")),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket,
        send_message_dto_1.SendMessageDto]),
    __metadata("design:returntype", Promise)
], MessagesGateway.prototype, "handleJoinRoom", null);
exports.MessagesGateway = MessagesGateway = __decorate([
    (0, websockets_1.WebSocketGateway)(80, {
        namespace: "/messages",
    }),
    __metadata("design:paramtypes", [message_datasource_1.MessageDatasource,
        jwt_1.JwtService,
        prisma_service_1.PrismaService])
], MessagesGateway);
//# sourceMappingURL=messages.gateway.js.map