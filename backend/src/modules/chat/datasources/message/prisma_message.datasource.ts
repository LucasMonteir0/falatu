import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageDatasource } from "./message.datasource";
import { CreateMessageDto } from "../../dtos/create_message_dto";
import { MessageEntity } from "../../entities/message.entity";
import { ConflictError, UnknownError } from "src/utils/result/AppError";
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
          new ConflictError("Message or User doesn't exists.")
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
          sender: QueryHelper.selectUser(),
          messageReads: QueryHelper.includeReadsWithUser(),
        },
      });

      return ResultWrapper.success(
        MessageEntity.fromPrisma(result, result.sender)
      );
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
        ResultWrapper.error(new ConflictError("Chat doesn't exists."));
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
            sender: QueryHelper.selectUser(),
            messageReads: QueryHelper.includeReadsWithUser(),
          },
        });

        let newMessage = MessageEntity.fromPrisma(query, query.sender);
        await this.updateMessageRead(newMessage.id, newMessage.sender.id);

        return newMessage;
      });

      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
  async getByChat(id: string): Promise<ResultWrapper<MessageEntity[]>> {
    try {
      const chatExists = await this.database.chat.findUnique({
        where: { id },
      });

      if (!chatExists) {
        ResultWrapper.error(new ConflictError("Chat doesn't exists."));
      }

      const messages = await this.database.message.findMany({
        where: {
          chatMessages: {
            some: { chatId: id },
          },
        },
        include: {
          sender: QueryHelper.selectUser(),
          messageReads: QueryHelper.includeReadsWithUser(),
        },
      });

      const result = messages.map((m) => MessageEntity.fromPrisma(m, m.sender));
      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
}
