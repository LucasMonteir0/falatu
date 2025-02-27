import "package:falatu_mobile/chat/core/data/datasources/chat/chat_datasource.dart";
import "package:falatu_mobile/chat/core/data/models/chat/create_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/create_chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _datasource;

  ChatRepositoryImpl(this._datasource);

  @override
  ResultWrapper<Stream<ChatEntity>> createChat(CreateChatEntity params) {
    final model = CreateChatModel.fromObject(params);
    return _datasource.createChat(model);
  }

  @override
  Future<ResultWrapper<Stream<List<ChatEntity>>>> loadChats() {
    return _datasource.loadChats();
  }

  @override
  void updateLastMessage({required String chatId, required String messageId}) {
    return _datasource.updateLastMessage(chatId: chatId, messageId: messageId);
  }
}
