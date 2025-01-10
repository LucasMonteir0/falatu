"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatModule = void 0;
const common_1 = require("@nestjs/common");
const chat_controller_1 = require("./chat.controller");
const chat_gateway_1 = require("./gateways/chat.gateway");
const chat_datasource_1 = require("./datasources/chat/chat.datasource");
const prisma_chat_datasource_1 = require("./datasources/chat/prisma_chat.datasource");
const message_datasource_1 = require("./datasources/message/message.datasource");
const prisma_message_datasource_1 = require("./datasources/message/prisma_message.datasource");
let ChatModule = class ChatModule {
};
exports.ChatModule = ChatModule;
exports.ChatModule = ChatModule = __decorate([
    (0, common_1.Module)({
        imports: [],
        controllers: [chat_controller_1.ChatController],
        providers: [
            {
                provide: chat_datasource_1.ChatDatasource,
                useClass: prisma_chat_datasource_1.PrismaChatDatasourceImpl,
            },
            {
                provide: message_datasource_1.MessageDatasource,
                useClass: prisma_message_datasource_1.PrismaMessageDatasourceImpl,
            },
            chat_gateway_1.ChatGateway,
        ],
    })
], ChatModule);
//# sourceMappingURL=chat.module.js.map