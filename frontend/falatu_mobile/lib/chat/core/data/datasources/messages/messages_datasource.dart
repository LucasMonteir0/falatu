import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class MessagesDatasource {
  Future<ResultWrapper<Stream<List<MessageEntity>>>> loadMessages(
      String chatId);

  Future<ResultWrapper<List<MessageEntity>>> getMessages(
      {required String chatId, required int page});

  void addOldMessages(String chatId, int page);

  void sendMessage(String chatId, SendMessageEntity message);

  void leaveChat();

  Future<ResultWrapper<String>> uploadMessageFile(
      String chatId, XFile file, MessageType type);
}
