import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/repositories/messages/messages_repository.dart";
import "package:falatu_mobile/chat/core/domain/usecases/send_message/send_message_use_case.dart";

class SendMessageUseCaseImpl implements SendMessageUseCase {
  final MessagesRepository _repository;

  SendMessageUseCaseImpl(this._repository);

  @override
  void call(String chatId, SendMessageEntity message) {
    return _repository.sendMessage(chatId, message);
  }
}
