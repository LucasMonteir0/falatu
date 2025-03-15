import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendTextMessageEntity extends SendMessageEntity {
  const SendTextMessageEntity({
    required super.senderId,
    required super.text,
    super.type = MessageType.text,
  });
}
