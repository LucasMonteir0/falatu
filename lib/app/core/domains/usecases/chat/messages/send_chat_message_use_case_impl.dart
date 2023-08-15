import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';
import 'package:falatu/app/core/domains/usecases/chat/messages/send_chat_message_use_case.dart';

class SendChatMessageUseCaseImpl implements SendChatMessageUseCase{

  final ChatRepository _repository;

  SendChatMessageUseCaseImpl(this._repository);
  @override
  Future<void> sendChatMessage(ChatEntity chat, MessageEntity message) async {
    await _repository.sendChatMessage(chat, message);
  }
}