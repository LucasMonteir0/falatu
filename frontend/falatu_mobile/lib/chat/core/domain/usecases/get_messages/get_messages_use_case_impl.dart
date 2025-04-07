import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/get_messages/get_messages_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class GetMessagesUseCaseImpl implements GetMessagesUseCase {
  final MessagesRepository _repository;

  GetMessagesUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<List<MessageEntity>>> call(
      {required String chatId, required int page}) {
    return _repository.getMessages(chatId: chatId, page: page);
  }
}
