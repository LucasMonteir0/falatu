import "package:falatu_mobile/chat/core/data/datasources/messages/messages_datasource.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesDatasource _datasource;

  MessagesRepositoryImpl(this._datasource);

  @override
  Stream<List<MessageEntity>> loadMessages(String chatId) {
    return _datasource.loadMessages(chatId);
  }

  @override
  void sendMessage(String chatId, SendMessageEntity message) {
    return _datasource.sendMessage(chatId, message);
  }
}
