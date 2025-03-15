import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendFileMessageEntity extends SendMessageEntity {
  const SendFileMessageEntity({
    required super.senderId,
    required super.mediaFile,
    super.type = MessageType.file,
  });
}