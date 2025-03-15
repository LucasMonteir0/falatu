import { IsNotEmpty } from "class-validator";
import { MessageType } from "../enums/message_type.enum";

export class UploadMessageFileDTO {
  @IsNotEmpty()
  type: MessageType;
  @IsNotEmpty()
  chatId: string;
}
