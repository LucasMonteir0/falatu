import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/leave_chat_use_case/leave_chat_use_case.dart";

class LeaveChatUseCaseImpl implements LeaveChatUseCase {
  final MessagesRepository _repository;

  LeaveChatUseCaseImpl(this._repository);

  @override
  void call() {
    return _repository.leaveChat();
  }
}
