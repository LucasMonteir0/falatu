import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class MessagesDatasource {
  ResultWrapper<Stream<List<MessageEntity>>> loadMessages(String chatId);

  void sendMessage(
      String chatId, SendMessageEntity message);

  void dispose();
}
