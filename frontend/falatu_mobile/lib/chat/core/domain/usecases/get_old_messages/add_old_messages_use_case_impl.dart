import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/get_old_messages/add_old_messages_use_case.dart";
import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";

class AddOldMessagesUseCaseImpl implements AddOldMessagesUseCase {
  final MessagesRepository _repository;

  AddOldMessagesUseCaseImpl(this._repository);

  @override
  void call(String chatId, int page) {
    return _repository.addOldMessages(chatId, page);
  }
}
