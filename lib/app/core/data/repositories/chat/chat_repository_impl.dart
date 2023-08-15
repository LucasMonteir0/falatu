import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/models/chat_model.dart';
import 'package:falatu/app/core/data/models/message_model.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _datasource;

  ChatRepositoryImpl(this._datasource);

  @override
  Stream<List<ChatModel>> getPrivateChats(String userId) {
    return _datasource.getPrivateChats(userId);
  }

  @override
  Stream<List<MessageModel>> getChatMessages(String chatId) {
    return _datasource.getChatMessages(chatId);
  }

  @override
  Future<void> sendChatMessage(ChatEntity chat, MessageEntity message) async {
    await _datasource.sendChatMessage(
      ChatModel.fromEntity(chat),
      MessageModel.fromEntity(message),
    );
  }
}
