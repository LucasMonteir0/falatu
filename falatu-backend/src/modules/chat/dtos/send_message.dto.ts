import { IsNotEmpty, IsUrl, IsUUID } from "class-validator";
import { MessageType } from "../enums/message_type.enum";

export class SendMessageDto {
  @IsUUID()
  public senderId: string;

  @IsNotEmpty()
  public type: MessageType;

  public text?: string;

  @IsUrl()
  public mediaUrl?: string;

  constructor({
    senderId,
    type,
    text,
    mediaUrl,
  }: {
    senderId: string;
    type: MessageType;
    text?: string;
    mediaUrl?: string;
  }) {
    this.senderId = senderId;
    this.type = type;
    this.text = text;
    this.mediaUrl = mediaUrl;
  }
}
