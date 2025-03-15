import {
  Body,
  Controller,
  Get,
  Post,
  Query,
  UploadedFile,
  UseInterceptors,
} from "@nestjs/common";
import { MessageDatasource } from "./datasources/message/message.datasource";
import {
  BucketOptions,
  BucketService,
} from "src/utils/config/bucket/bucket.service";
import { FileInterceptor } from "@nestjs/platform-express";
import { UploadMessageFileDTO } from "./dtos/upload_message_file.dto";
import { MessageUtils } from "./utils/message.utils";
import { FileHelper } from "src/utils/helpers/file.helper";

@Controller("messages")
export class MessageController {
  constructor(
    private readonly datasource: MessageDatasource,
    private readonly bucket: BucketService
  ) {}

  @Get()
  async getByChat(
    @Query("chatId") userId: string,
    @Query("page") page: number
  ) {
    const result = await this.datasource.getByChat(userId, page);
    if (result.isSuccess) {
      return result.data;
    }
    throw result.error;
  }

  @Post("upload-file")
  @UseInterceptors(FileInterceptor("file"))
  async uploadFile(
    @UploadedFile() file: Express.Multer.File,
    @Body() body: UploadMessageFileDTO
  ) {
    const { type, chatId } = body;
    const fileParts = file.originalname.split(".");
    const extension = fileParts[fileParts.length - 1];

    const bucketOptions: BucketOptions = {
      path: `chats/${chatId}`,
      fileName: MessageUtils.handleFileMessageName(type, fileParts[0]),
      extension: extension,
      file: file,
      contentType: FileHelper.getContentTypeFromExtension(extension),
    };

    const result = await this.bucket.uploadFile(bucketOptions);
    return { url: result };
  }
}
