import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/create_chat_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class CreateChatUseCase {
  ResultWrapper<Stream<ChatEntity>> call(CreateChatEntity params);
}
