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
let ChatGateway = class ChatGateway {
    constructor(datasource) {
        this.datasource = datasource;
    }
    handleConnection(client, ...args) {
        const userId = client.handshake.query.userId;
        if (!userId) {
            client.disconnect();
            return new AppError_1.BadRequestError("User id must be provided.");
        }
    }
    handleDisconnect(client) { }
    async handleJoinRoom(client) {
        const userId = client.handshake.query.userId;
        console.log(userId);
        const chats = await this.datasource.getChatsByUser(userId);
        if (chats.isSuccess) {
            this.server.emit("load-chats", { chats: chats.data });
        }
    }
};
exports.ChatGateway = ChatGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], ChatGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)("loadChats"),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleJoinRoom", null);
exports.ChatGateway = ChatGateway = __decorate([
    (0, websockets_1.WebSocketGateway)(80, {
        namespace: "/chat",
    }),
    __metadata("design:paramtypes", [chat_datasource_1.ChatDatasource])
], ChatGateway);
//# sourceMappingURL=chat.gateway.js.map