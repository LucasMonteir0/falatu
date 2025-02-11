import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";

abstract class MessagesRepository {
  Stream<List<MessageEntity>> loadMessages(String chatId);

  void sendMessage(String chatId, SendMessageEntity message);
}
