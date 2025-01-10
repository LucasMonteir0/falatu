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
Object.defineProperty(exports, "__esModule", { value: true });
exports.PrismaMessageDatasourceImpl = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../../../../utils/config/database/prisma.service");
const ResultWrapper_1 = require("../../../../utils/result/ResultWrapper");
const message_entity_1 = require("../../entities/message.entity");
const AppError_1 = require("../../../../utils/result/AppError");
const query_helper_1 = require("../../../../utils/helpers/query.helper");
let PrismaMessageDatasourceImpl = class PrismaMessageDatasourceImpl {
    constructor(database) {
        this.database = database;
    }
    async sendMessage(message, chatId) {
        try {
            const chatExists = await this.database.chat.findUnique({
                where: { id: chatId },
            });
            if (!chatExists) {
                ResultWrapper_1.ResultWrapper.error(new AppError_1.ConflictError("Chat doesn't exists."));
            }
            const result = await this.database.message.create({
                data: {
                    type: message.type,
                    senderId: message.senderId,
                    text: message.text,
                    media_url: null,
                    chatMessages: {
                        create: {
                            chatId: chatId,
                        },
                    },
                },
                include: {
                    sender: query_helper_1.QueryHelper.selectUser(),
                },
            });
            return ResultWrapper_1.ResultWrapper.success(message_entity_1.MessageEntity.fromPrisma(result, result.sender));
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(new AppError_1.UnknownError(e));
        }
    }
    async getMessagesByChatId(id) {
        try {
            const chatExists = await this.database.chat.findUnique({
                where: { id },
            });
            if (!chatExists) {
                ResultWrapper_1.ResultWrapper.error(new AppError_1.ConflictError("Chat doesn't exists."));
            }
            const messages = await this.database.message.findMany({
                where: {
                    chatMessages: {
                        some: { chatId: id },
                    },
                },
                include: {
                    sender: query_helper_1.QueryHelper.selectUser(),
                },
            });
            const result = messages.map((m) => message_entity_1.MessageEntity.fromPrisma(m, m.sender));
            return ResultWrapper_1.ResultWrapper.success(result);
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(new AppError_1.UnknownError(e));
        }
    }
};
exports.PrismaMessageDatasourceImpl = PrismaMessageDatasourceImpl;
exports.PrismaMessageDatasourceImpl = PrismaMessageDatasourceImpl = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], PrismaMessageDatasourceImpl);
//# sourceMappingURL=prisma_message.datasource.js.map