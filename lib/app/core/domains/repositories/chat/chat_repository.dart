import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getPrivateChats(String userId);
  Stream<List<MessageEntity>> getChatMessages(String chatId);
}