import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class LoadMessagesUseCase {
  ResultWrapper<Stream<List<MessageEntity>>> call(String chatId);
}
