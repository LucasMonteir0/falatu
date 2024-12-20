import { Injectable } from "@nestjs/common";
import { CreateChatDTO } from "../dtos/create_chat.dto";
import { ChatEntity } from "../entities/chat.entity";
import { ChatDatasource } from "./chat.datasource";
import { PrismaService } from "src/config/database/prisma.service";
import {
  BadRequestError,
  ConflictError,
  UnknownError,
} from "src/utils/result/AppError";
import { UserEntity } from "src/http/commons/entities/user.entity";
import { ResultWrapper } from "src/utils/result/ResultWrapper";

@Injectable()
export class PrismaChatDatasourceImpl implements ChatDatasource {
  constructor(private readonly database: PrismaService) {}
  async createChat(params: CreateChatDTO): Promise<ResultWrapper<ChatEntity>> {
    try {
      if (params.type === "private") {
        if (params.usersIds.length !== 2) {
          throw new BadRequestError("Private chats must have exactly 2 users.");
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
          return ResultWrapper.error(
            new ConflictError("A chat with this user already exists.")
          );
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
        const mappedUsers = users.map((u) => UserEntity.fromPrisma(u));
        return ResultWrapper.success(ChatEntity.fromPrisma(chat, mappedUsers));
      } else if (params.type === "group") {
        if (!params.title) {
          return ResultWrapper.error(
            new BadRequestError("Goup chats must have a title.")
          );
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

        const mappedUsers = users.map((u) => UserEntity.fromPrisma(u));
        return ResultWrapper.success(ChatEntity.fromPrisma(chat, mappedUsers));
      } else {
        return ResultWrapper.error(
          new BadRequestError("Tipo de chat inválido.")
        );
      }
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
}
