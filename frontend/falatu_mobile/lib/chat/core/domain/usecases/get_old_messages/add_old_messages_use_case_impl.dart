import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/get_old_messages/add_old_messages_use_case.dart";

class AddOldMessagesUseCaseImpl implements AddOldMessagesUseCase {
  final MessagesRepository _repository;

  AddOldMessagesUseCaseImpl(this._repository);

  @override
  void call(String chatId, int page) {
    return _repository.addOldMessages(chatId, page);
  }
}
