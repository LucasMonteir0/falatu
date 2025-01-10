import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/utils/config/database/prisma.service";
import { ResultWrapper } from "src/utils/result/ResultWrapper";
import { MessageDatasource } from "./message.datasource";
import { SendMessageDto } from "../../dtos/send_message.dto";
import { MessageEntity } from "../../entities/message.entity";
import { ConflictError, UnknownError } from "src/utils/result/AppError";
import { QueryHelper } from "src/utils/helpers/query.helper";

@Injectable()
export class PrismaMessageDatasourceImpl implements MessageDatasource {
  constructor(private readonly database: PrismaService) {}
  async sendMessage(
    message: SendMessageDto,
    chatId: string
  ): Promise<ResultWrapper<MessageEntity>> {
    try {
      const chatExists = await this.database.chat.findUnique({
        where: { id: chatId },
      });

      if (!chatExists) {
        ResultWrapper.error(new ConflictError("Chat doesn't exists."));
      }

      const result = await this.database.message.create({
        data: {
          type: message.type,
          senderId: message.senderId,
          text: message.text,
          media_url: null, //TODO message.mediaFile,
          chatMessages: {
            create: {
              chatId: chatId,
            },
          },
        },
        include: {
          sender: QueryHelper.selectUser(),
        },
      });

      return ResultWrapper.success(
        MessageEntity.fromPrisma(result, result.sender)
      );
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
  async getMessagesByChatId(
    id: string
  ): Promise<ResultWrapper<MessageEntity[]>> {
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
        },
      });

      const result = messages.map((m) => MessageEntity.fromPrisma(m, m.sender));
      return ResultWrapper.success(result);
    } catch (e) {
      return ResultWrapper.error(new UnknownError(e));
    }
  }
}
