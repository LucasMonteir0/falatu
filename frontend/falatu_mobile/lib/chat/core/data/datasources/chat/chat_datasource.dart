import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class ChatDatasource {
  ResultWrapper<Stream<List<ChatEntity>>> loadChats();

  Future<ResultWrapper<ChatEntity>> create();

  void dispose();
}
