import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

abstract class GetMessagesUseCase {
  Future<ResultWrapper<List<MessageEntity>>> call(
      {required String chatId, required int page});
}
