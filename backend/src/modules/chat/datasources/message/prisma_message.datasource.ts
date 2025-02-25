import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageDatasource } from "./message.datasource";
import { CreateMessageDto } from "../../dtos/create_message_dto";
import { MessageEntity } from "../../entities/message.entity";
import { UnknownError, NotFoundError } from "src/utils/result/AppError";
import { QueryHelper } from "src/utils/helpers/query.helper";

@Injectable()
export class PrismaMessageDatasourceImpl implements MessageDatasource {
  constructor(private readonly database: PrismaService) {}
  async updateMessageRead(
    messageId: string,
    userId: string
  ): Promise<ResultWrapper<MessageEntity>> {
    try {
      const messageExists = await this.database.message.findUnique({
        where: { id: messageId },
      });

      const userExists = await this.database.user.findUnique({
        where: { id: userId },
      });

      if (!messageExists || !userExists) {
        ResultWrapper.error(
          new NotFoundError("Message or User doesn't exists.")
        );
      }

      const messageRead = await this.database.messageRead.create({
        data: {
          messageId,
          userId,
        },
      });

      const result = await this.database.message.findUnique({
        where: { id: messageRead.messageId },
        include: {
          sender: true,
          messageReads: QueryHelper.includeReadsWithUser(),
        },
      });

      return ResultWrapper.success(MessageEntity.fromPrisma(result));
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }

  async create(
    message: CreateMessageDto,
    chatId: string
  ): Promise<ResultWrapper<MessageEntity>> {
    try {
      const chatExists = await this.database.chat.findUnique({
        where: { id: chatId },
      });

      if (!chatExists) {
        ResultWrapper.error(new NotFoundError("Chat doesn't exists."));
      }

      const result = await this.database.$transaction(async (transaction) => {
        let query = await transaction.message.create({
          data: {
            type: message.type,
            senderId: message.senderId,
            text: message.text,
            media_url: null,
            Chat: { connect: { id: chatId } },
            chatMessages: {
              create: {
                chatId: chatId,
              },
            },
            messageReads: {
              create: {
                userId: message.senderId,
              },
            },
          },
          include: {
            sender: true,
            messageReads: QueryHelper.includeReadsWithUser(),
          },
        });

        await transaction.chat.update({
          where: { id: chatId },
          data: {
            lastMessageId: query.id,
          },
        });

        let newMessage = MessageEntity.fromPrisma(query);
        return newMessage;
      });

      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }

  async getByChat(
    id: string,
    page: number = 1,
    pageSize: number = 100
  ): Promise<ResultWrapper<MessageEntity[]>> {
    try {
      const chatExists = await this.database.chat.findUnique({
        where: { id },
      });

      if (!chatExists) {
        ResultWrapper.error(new NotFoundError("Chat doesn't exists."));
      }

      const messages = await this.database.message.findMany({
        where: {
          chatMessages: {
            some: { chatId: id },
          },
        },
        include: {
          sender: true,
          messageReads: QueryHelper.includeReadsWithUser(),
        },
        orderBy: {
          createdAt: "desc", // Pegando as mensagens mais recentes primeiro
        },
        skip: (page - 1) * pageSize, // Paginação baseada no número da página
        take: pageSize,
      });

      const result = messages.map((m) => MessageEntity.fromPrisma(m));
      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
}
