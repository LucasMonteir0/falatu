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
exports.PrismaChatDatasourceImpl = void 0;
const common_1 = require("@nestjs/common");
const chat_entity_1 = require("../entities/chat.entity");
const prisma_service_1 = require("../../../config/database/prisma.service");
const AppError_1 = require("../../../utils/result/AppError");
const user_entity_1 = require("../../commons/entities/user.entity");
const ResultWrapper_1 = require("../../../utils/result/ResultWrapper");
let PrismaChatDatasourceImpl = class PrismaChatDatasourceImpl {
    constructor(database) {
        this.database = database;
    }
    async createChat(params) {
        try {
            if (params.type === "private") {
                if (params.usersIds.length !== 2) {
                    throw new AppError_1.BadRequestError("Private chats must have exactly 2 users.");
                }
                const existingChat = await this.database.chat.findFirst({
                    where: {
                        type: "private",
                        userChats: {
                            every: {
                                userId: { in: params.usersIds },
                            },
                        },
                    },
                });
                if (existingChat) {
                    return ResultWrapper_1.ResultWrapper.error(new AppError_1.ConflictError("A chat with this user already exists."));
                }
                const chat = await this.database.chat.create({
                    data: {
                        type: "private",
                        userChats: {
                            create: params.usersIds.map((userId) => ({
                                userId,
                                role: "member",
                            })),
                        },
                    },
                    include: {
                        userChats: true,
                    },
                });
                const users = await this.database.user.findMany({
                    where: {
                        userChats: {
                            some: {
                                chatId: chat.id,
                            },
                        },
                    },
                });
                const mappedUsers = users.map((u) => user_entity_1.UserEntity.fromPrisma(u));
                return ResultWrapper_1.ResultWrapper.success(chat_entity_1.ChatEntity.fromPrisma(chat, mappedUsers));
            }
            else if (params.type === "group") {
                if (!params.title) {
                    return ResultWrapper_1.ResultWrapper.error(new AppError_1.BadRequestError("Goup chats must have a title."));
                }
                const chat = await this.database.chat.create({
                    data: {
                        type: "group",
                        title: params.title,
                        picture_url: params.pictureUrl,
                        userChats: {
                            create: params.usersIds.map((userId, index) => ({
                                userId,
                                role: index === 0 ? "admin" : "member",
                            })),
                        },
                    },
                    include: {
                        userChats: true,
                    },
                });
                const users = await this.database.user.findMany({
                    where: {
                        userChats: {
                            some: {
                                chatId: chat.id,
                            },
                        },
                    },
                });
                const mappedUsers = users.map((u) => user_entity_1.UserEntity.fromPrisma(u));
                return ResultWrapper_1.ResultWrapper.success(chat_entity_1.ChatEntity.fromPrisma(chat, mappedUsers));
            }
            else {
                return ResultWrapper_1.ResultWrapper.error(new AppError_1.BadRequestError("Tipo de chat inválido."));
            }
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(new AppError_1.UnknownError(e));
        }
    }
};
exports.PrismaChatDatasourceImpl = PrismaChatDatasourceImpl;
exports.PrismaChatDatasourceImpl = PrismaChatDatasourceImpl = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], PrismaChatDatasourceImpl);
//# sourceMappingURL=prisma_chat.datasource.js.map