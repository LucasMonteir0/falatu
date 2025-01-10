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
const chat_entity_1 = require("../../entities/chat.entity");
const prisma_service_1 = require("../../../../utils/config/database/prisma.service");
const AppError_1 = require("../../../../utils/result/AppError");
const ResultWrapper_1 = require("../../../../utils/result/ResultWrapper");
const chat_user_entity_1 = require("../../entities/chat_user.entity");
const chat_utils_1 = require("../../utils/chat.utils");
const chat_role_enum_1 = require("../../enums/chat_role.enum");
let PrismaChatDatasourceImpl = class PrismaChatDatasourceImpl {
    constructor(database) {
        this.database = database;
    }
    async getUsersByChatId(id) {
        try {
            const chat = await this.database.chat.findUnique({
                where: { id: id },
                select: {
                    userChats: {
                        include: {
                            user: true,
                        },
                    },
                },
            });
            if (!chat) {
                return ResultWrapper_1.ResultWrapper.error(new AppError_1.NotFoundError("This chat doen't exists."));
            }
            return ResultWrapper_1.ResultWrapper.success(chat.userChats.map((c) => chat_user_entity_1.ChatUserEntity.fromPrisma(c.user, chat_utils_1.ChatUtils.roleFromValue(c.role))));
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(new AppError_1.UnknownError(e));
        }
    }
    async getChatsByUserId(id) {
        const chats = await this.database.chat.findMany({
            where: {
                userChats: {
                    none: {
                        userId: id,
                    },
                },
            },
            include: {
                userChats: {
                    include: {
                        user: true,
                    },
                },
            },
        });
        const result = chats.map((c) => chat_entity_1.ChatEntity.fromPrisma(c, c.userChats.map((u) => chat_user_entity_1.ChatUserEntity.fromPrisma(u.user, chat_utils_1.ChatUtils.roleFromValue(u.role)))));
        return ResultWrapper_1.ResultWrapper.success(result);
    }
    async getChatById(id) {
        try {
            const chat = await this.database.chat.findUnique({
                where: { id: id },
                include: {
                    userChats: {
                        include: {
                            user: true,
                        },
                    },
                },
            });
            if (chat) {
                return ResultWrapper_1.ResultWrapper.error(new AppError_1.NotFoundError("This chat doen't exists."));
            }
            return ResultWrapper_1.ResultWrapper.success(chat_entity_1.ChatEntity.fromPrisma(chat, chat.userChats.map((e) => chat_user_entity_1.ChatUserEntity.fromPrisma(e.user, chat_utils_1.ChatUtils.roleFromValue(e.role)))));
        }
        catch (e) {
            return ResultWrapper_1.ResultWrapper.error(new AppError_1.UnknownError(e));
        }
    }
    async createChat(params) {
        try {
            if (params.type === "private") {
                if (params.usersIds.length !== 2) {
                    return ResultWrapper_1.ResultWrapper.error(new AppError_1.BadRequestError("Private chats must have exactly 2 users."));
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
                        userChats: {
                            include: {
                                user: true,
                            },
                        },
                    },
                });
                return ResultWrapper_1.ResultWrapper.success(chat_entity_1.ChatEntity.fromPrisma(chat, chat.userChats.map((e) => chat_user_entity_1.ChatUserEntity.fromPrisma(e.user, chat_utils_1.ChatUtils.roleFromValue(e.role)))));
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
                                role: index === 0 ? chat_role_enum_1.ChatRole.ADMIN : chat_role_enum_1.ChatRole.MEMBER,
                            })),
                        },
                    },
                    include: {
                        userChats: {
                            include: {
                                user: true,
                            },
                        },
                    },
                });
                return ResultWrapper_1.ResultWrapper.success(chat_entity_1.ChatEntity.fromPrisma(chat, chat.userChats.map((e) => chat_user_entity_1.ChatUserEntity.fromPrisma(e.user, chat_utils_1.ChatUtils.roleFromValue(e.role)))));
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