import "package:falatu_mobile/chat/core/data/models/chat/create_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class ChatDatasource {
  Future<ResultWrapper<Stream<List<ChatEntity>>>> loadChats();

  ResultWrapper<Stream<ChatEntity>> createChat(CreateChatModel params);

}
