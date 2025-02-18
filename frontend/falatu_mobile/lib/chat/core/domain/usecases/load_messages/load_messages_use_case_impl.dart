import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/load_messages/load_messages_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class LoadMessagesUseCaseImpl implements LoadMessagesUseCase {
  final MessagesRepository _repository;

  LoadMessagesUseCaseImpl(this._repository);

  @override
  ResultWrapper<Stream<List<MessageEntity>>> call(String chatId) {
    return _repository.loadMessages(chatId);
  }
}
