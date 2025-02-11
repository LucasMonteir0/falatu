import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

abstract class LoadMessagesUseCase {
  Stream<List<MessageEntity>> call(String chatId);
}
