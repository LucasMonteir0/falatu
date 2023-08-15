import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_chat_messages_use_case.dart';

class GetChatMessagesUseCaseImpl extends GetChatMessagesUseCase {
  final ChatRepository _repository;

  GetChatMessagesUseCaseImpl(this._repository);

  @override
  Stream<List<MessageEntity>> getChatMessages(String chatId) {
    return _repository.getChatMessages(chatId);
  }
}
