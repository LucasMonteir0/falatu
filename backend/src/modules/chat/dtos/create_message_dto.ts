import { IsNotEmpty, IsUUID } from "class-validator";
import { MessageType } from "../enums/message_type.enum";

export class CreateMessageDto {
  @IsUUID()
  public senderId: string;

  @IsNotEmpty()
  public type: MessageType;

  public text?: string;

  public mediaFile?: Express.Multer.File;

  constructor({
    senderId,
    type,
    text,
    mediaFile,
  }: {
    senderId: string;
    type: MessageType;
    text?: string;
    mediaFile?: Express.Multer.File;
  }) {
    this.senderId = senderId;
    this.type = type;
    this.text = text;
    this.mediaFile = mediaFile;
  }
}
