import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageDatasource } from "./message.datasource";
import { CreateMessageDto } from "../../dtos/create_message.dto";
import { MessageEntity } from "../../entities/message.entity";
import { UnknownError, NotFoundError } from "src/utils/result/AppError";
import { QueryHelper } from "src/utils/helpers/query.helper";
import {
  BucketOptions,
  BucketService,
} from "src/utils/config/bucket/bucket.service";
import { MessageUtils } from "../../utils/message.utils";

@Injectable()
export class PrismaMessageDatasourceImpl implements MessageDatasource {
  constructor(
    private readonly database: PrismaService,
    private readonly bucket: BucketService
  ) {}

  async readMessagesByChat(
    chatId: string,
    userId: string
  ): Promise<ResultWrapper<boolean>> {
    try {
      const userExists = await this.database.user.findUnique({
        where: { id: userId },
      });

      if (!userExists) {
        return ResultWrapper.error(
          new NotFoundError("Message or User doesn't exists.")
        );
      }

      const unreadMessages = await this.database.message.findMany({
        where: {
          chatMessages: {
            some: { chatId },
          },
          messageReads: {
            none: { userId: userId },
          },
        },
      });

      if (unreadMessages.length > 0) {
        await this.database.messageRead.createMany({
          data: unreadMessages.map((message) => ({
            messageId: message.id,
            userId: userId,
          })),
        });
        return ResultWrapper.success(true);
      }

      return ResultWrapper.success(false);
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
            media_url: message.mediaUrl,
            thumb_url: message.thumbUrl,
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
    pageSize: number = 10
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
          createdAt: "desc",
        },
        skip: (page - 1) * pageSize,
        take: pageSize,
      });

      const result = messages.map((m) => MessageEntity.fromPrisma(m));
      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
}
