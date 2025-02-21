import "package:falatu_mobile/chat/core/domain/repositories/chat/chat_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/update_last_message/update_last_message_use_case.dart";

class UpdateLastMessageUseCaseImpl implements UpdateLastMessageUseCase {
  final ChatRepository _repository;

  UpdateLastMessageUseCaseImpl(this._repository);

  @override
  void call({required String chatId, required String messageId}) {
   return _repository.updateLastMessage(chatId: chatId, messageId: messageId);
  }
}