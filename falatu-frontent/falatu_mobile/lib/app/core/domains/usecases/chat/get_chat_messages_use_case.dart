import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';

abstract class GetChatMessagesUseCase {
  Stream<List<MessageEntity>> getChatMessages(String chatId);
}