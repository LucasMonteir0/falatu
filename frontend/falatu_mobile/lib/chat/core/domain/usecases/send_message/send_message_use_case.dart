import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";

abstract class SendMessageUseCase {
  void call(String chatId, SendMessageEntity message);
}