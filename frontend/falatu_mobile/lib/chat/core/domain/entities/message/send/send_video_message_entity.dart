import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendVideoMessageEntity extends SendMessageEntity {
  const SendVideoMessageEntity({
    required super.senderId,
    required super.mediaFile,
    super.text,
    super.type = MessageType.video,
  });
}
