import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class MessagesRepository {
  Future<ResultWrapper<Stream<List<MessageEntity>>>> loadMessages(
      String chatId);

  void addOldMessages(String chatId, int page);

  void sendMessage(String chatId, SendMessageEntity message);
}
