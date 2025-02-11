import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class LoadChatsUseCase {
  ResultWrapper<Stream<List<ChatEntity>>> call();
}
