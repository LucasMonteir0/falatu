import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/api_result.dart";

abstract class ChatRepository{
  ApiResult<Stream<List<ChatEntity>>> loadChats();

  Future<ApiResult<ChatEntity>> create();
}