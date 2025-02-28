import { Injectable } from "@nestjs/common";
import { CreateChatDTO } from "../../dtos/create_chat.dto";
import { ChatEntity } from "../../entities/chat.entity";
import { ChatDatasource } from "./chat.datasource";
import { PrismaService } from "src/utils/config/database/prisma.service";
import {
  BadRequestError,
  ConflictError,
  NotFoundError,
  UnknownError,
} from "src/utils/result/AppError";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { ChatUserEntity } from "../../entities/chat_user.entity";
import { ChatUtils } from "../../utils/chat.utils";
import { ChatRole } from "../../enums/chat_role.enum";
import { QueryHelper } from "src/utils/helpers/query.helper";

@Injectable()
export class PrismaChatDatasourceImpl implements ChatDatasource {
  constructor(private readonly database: PrismaService) {}

  //ATUALIZAR ULTIMA MENSAGEM ENVIADA NO CHAT
  async updateLastMessage(
    chatId: string,
    messageId: string
  ): Promise<ResultWrapper<ChatEntity>> {
    try {
      const chat = await this.database.chat.update({
        where: { id: chatId },
        data: { lastMessageId: messageId },
        include: QueryHelper.includesOnChat(),
      });

      return ResultWrapper.success(ChatEntity.fromPrisma(chat));
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }

  //BUSCAR USUARIOS DE UM CHAT
  async getUsersByChatId(id: string): Promise<ResultWrapper<ChatUserEntity[]>> {
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
        return ResultWrapper.error(
          new NotFoundError("This chat doen't exists.")
        );
      }

      return ResultWrapper.success(
        chat.userChats.map((c) =>
          ChatUserEntity.fromPrisma(c.user, ChatUtils.roleFromValue(c.role))
        )
      );
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }

  //BUSCAR CHATS DE UM USUÁRIO
  async getChatsByUserId(id: string): Promise<ResultWrapper<ChatEntity[]>> {
    if (!id) {
      return ResultWrapper.error(new BadRequestError("userId is missing."));
    }
    try {
      const chats = await this.database.chat.findMany({
        where: {
          userChats: {
            some: {
              userId: id,
            },
          },
        },
        orderBy: [
          {
            createdAt: "desc",
          },
        ],
        include: {
          ...QueryHelper.includesOnChat(),
          chatMessages: {
            include: {
              message: {
                include: {
                  messageReads: true,
                },
              },
            },
          },
        },
      });

      chats.sort((a, b) => {
        const dateA = a.lastMessage?.createdAt ?? a.createdAt;
        const dateB = b.lastMessage?.createdAt ?? b.createdAt;
        return dateB.getTime() - dateA.getTime(); // Descendente
      });

      const result = chats.map((c) => {
        const unread = c.chatMessages.filter(
          (chatMessage) =>
            chatMessage.message.senderId !== id &&
            !chatMessage.message.messageReads.some((read) => read.userId === id)
        );
        return ChatEntity.fromPrisma(c, unread.length);
      });
      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }

  //BUSCAR UM CHAT POR ID
  async getChatById(id: string): Promise<ResultWrapper<ChatEntity>> {
    try {
      const chat = await this.database.chat.findUnique({
        where: { id: id },
        include: QueryHelper.includesOnChat(),
      });

      if (!chat) {
        return ResultWrapper.error(
          new NotFoundError("This chat doen't exists.")
        );
      }

      return ResultWrapper.success(ChatEntity.fromPrisma(chat));
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }

  //CRIAR UM CHAT
  async createChat(params: CreateChatDTO): Promise<ResultWrapper<ChatEntity>> {
    try {
      if (params.type === "private") {
        if (params.usersIds.length !== 2) {
          return ResultWrapper.error(
            new BadRequestError("Private chats must have exactly 2 users.")
          );
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
          include: QueryHelper.includesOnChat(),
        });

        return ResultWrapper.success(ChatEntity.fromPrisma(chat));
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
                role: index === 0 ? ChatRole.ADMIN : ChatRole.MEMBER,
              })),
            },
          },
          include: QueryHelper.includesOnChat(),
        });

        return ResultWrapper.success(ChatEntity.fromPrisma(chat));
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
